package com.howseasthma.howse_asthma

import android.app.*
import android.content.*
import android.os.Build
import org.json.JSONArray
import org.json.JSONObject
import java.text.SimpleDateFormat
import java.util.*

/** Direct local write: no activity launch, tokens, network call or audio. */
class DirectRecordReceiver: BroadcastReceiver() {
    override fun onReceive(context:Context,intent:Intent) {
        synchronized(DirectRecordReceiver::class.java) {
            val prefs=context.getSharedPreferences("cn_direct",Context.MODE_PRIVATE)
            val config=try{JSONObject(prefs.getString("config",null) ?: return)}catch(_:Exception){return}
            if(intent.getStringExtra("token")!=config.optString("token"))return
            if((context.getSystemService(Context.KEYGUARD_SERVICE) as KeyguardManager).isDeviceLocked)return
            val id=intent.getStringExtra("id") ?: return
            val owner=config.optString("owner")
            val patientKey=config.optString("patient_key")
            if(owner.isBlank()||(patientKey!=owner&&!patientKey.startsWith("$owner/")))return
            val queue=queue(context)
            if(intent.action=="cn.UNDO") {
                remove(context,owner,id)
                val tombstone=JSONObject().put("id",id).put("owner",owner).put("patient_key",patientKey).put("source_id",id).put("undone",true)
                val next=queue(context).put(tombstone)
                prefs.edit().putString("queue",next.toString()).commit()
                cancel(context);return
            }
            if(prefs.getString("last_id",null)==id)return
            val now=Date()
            val day=SimpleDateFormat("yyyy-MM-dd",Locale.US).format(now)
            val event=JSONObject().put("id",id).put("owner",owner).put("patient_key",patientKey).put("kind","medication_use")
                .put("day",day).put("source_id",id).put("text","Patient confirmed scheduled medicine use via notification; quantity unknown.")
                .put("synthetic",false).put("undone",false)
                .put("values",JSONObject().put("medication",config.optString("medication")).put("use_kind","scheduled")
                    .put("quantity",JSONObject.NULL).put("unit",JSONObject.NULL).put("input_path","notification")
                    .put("occurred_at",SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX",Locale.US).format(now)))
            queue.put(event)
            prefs.edit().putString("queue",queue.toString()).putString("last_id",id).commit()
            show(context,config,id,true)
        }
    }
    companion object {
        private const val ID=10410
        private const val CHANNEL="cn_direct_record_v1"
        fun queue(c:Context):JSONArray=try{JSONArray(c.getSharedPreferences("cn_direct",Context.MODE_PRIVATE).getString("queue","[]"))}catch(_:Exception){JSONArray()}
        fun remove(c:Context,owner:String,id:String) {
            val old=queue(c);val next=JSONArray()
            for(i in 0 until old.length()){val e=old.getJSONObject(i);if(e.optString("id")!=id||e.optString("owner",e.optString("patient_key"))!=owner)next.put(e)}
            c.getSharedPreferences("cn_direct",Context.MODE_PRIVATE).edit().putString("queue",next.toString()).commit()
        }
        fun asMap(j:JSONObject):Map<String,Any?> {
            val map=mutableMapOf<String,Any?>()
            j.keys().forEach { key -> val v=j.get(key);map[key]=when(v){JSONObject.NULL->null;is JSONObject->asMap(v);else->v} }
            return map
        }
        fun cancel(c:Context) {(c.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager).cancel(ID)}
        fun show(c:Context,config:JSONObject,id:String=UUID.randomUUID().toString(),saved:Boolean=false) {
            val manager=c.getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            if(Build.VERSION.SDK_INT>=26)manager.createNotificationChannel(NotificationChannel(CHANNEL,"CoverNote direct record",NotificationManager.IMPORTANCE_LOW))
            val intent=Intent(c,DirectRecordReceiver::class.java).setAction(if(saved)"cn.UNDO" else "cn.RECORD")
                .putExtra("token",config.optString("token")).putExtra("id",id)
            val pending=PendingIntent.getBroadcast(c,if(saved)10411 else 10410,intent,PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE)
            val action=Notification.Action.Builder(null,config.optString(if(saved)"undo" else "action"),pending)
            if(Build.VERSION.SDK_INT>=31)action.setAuthenticationRequired(true)
            val builder=if(Build.VERSION.SDK_INT>=26)Notification.Builder(c,CHANNEL)else Notification.Builder(c)
            builder.setSmallIcon(android.R.drawable.ic_menu_edit).setContentTitle("CoverNote")
                .setContentText(config.optString(if(saved)"saved" else "title"))
                .setVisibility(Notification.VISIBILITY_SECRET).setOnlyAlertOnce(true).setAutoCancel(false).addAction(action.build())
            try{manager.notify(ID,builder.build())}catch(_:SecurityException){/* Permission denied; Flutter reports setup requirement. */}
        }
    }
}
