"""Create clearly labelled fictional source files for the Sprint 10 recording."""
import json
from xml.sax.saxutils import escape
from pathlib import Path
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Table, TableStyle
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib import colors

root = Path('output/pdf/sprint10-demo')
root.mkdir(parents=True, exist_ok=True)
docs = json.loads(Path('build/sprint10/demo-documents.json').read_text(encoding='utf-8'))
lab = next(d for d in docs if d['kind'] == 'lab')
lab = {**lab, 'title': 'CBC with differential - patient result'}
docs = [lab if d['kind'] == 'lab' else d for d in docs]
paper = {**lab, 'file': '05-lab-paper-for-camera.pdf', 'title': 'Laboratory result - printed patient copy'}
for d in [*docs, paper]:
    styles = getSampleStyleSheet()
    story = [Paragraph('SAMPLE / SYNTHETIC - FOR SOFTWARE DEMONSTRATION ONLY', styles['Heading2']),
             Spacer(1, 12), Paragraph(d['title'], styles['Title']), Spacer(1, 12)]
    is_paper = d['file'].startswith('05-')
    if d['kind'] == 'lab':
        story.extend([Paragraph('DEMO COMMUNITY LABORATORY (FICTIONAL)', styles['Heading3']),
                      Paragraph('Patient copy - printed handout' if is_paper else 'Patient portal - downloaded results copy', styles['BodyText']), Spacer(1, 12)])
    elif d['kind'] == 'notice':
        story.extend([Paragraph('DEMO BENEFITS OFFICE - FICTIONAL CORRESPONDENCE', styles['Heading3']),
                      Paragraph('Delivery format: mailed patient notice. Notice ID: DEMO-NJ-2026-014. Not issued by a real insurer.', styles['BodyText']), Spacer(1, 12)])
    info = [['Patient', 'Diego Martinez (fictional)'], ['Date of birth', '2012-04-17 (age 14 in this scenario)'],
            ['Caregiver', 'Rosa Martinez'], ['Sample identifier', 'DEMO-DM-014'], ['Treatment start' if d['kind']=='prescription' else 'Record date', d['date']]]
    table=Table(info, colWidths=[110, 390], hAlign='LEFT')
    table.setStyle(TableStyle([('BACKGROUND',(0,0),(0,-1),colors.HexColor('#eef2f6')),('GRID',(0,0),(-1,-1),0.4,colors.grey),('FONTNAME',(0,0),(-1,-1),'Helvetica'),('FONTSIZE',(0,0),(-1,-1),9),('TOPPADDING',(0,0),(-1,-1),7),('BOTTOMPADDING',(0,0),(-1,-1),7)]))
    story.extend([table,Spacer(1,16)])
    if d['kind'] == 'lab':
        story.extend([Paragraph('CBC WITH DIFFERENTIAL - selected results', styles['Heading3']),
            Paragraph('Specimen: EDTA whole blood. Accession: DEMO-CBC-014. Status: FINAL (synthetic). Ordering service: Demo Pediatric Care (fictional).', styles['BodyText']), Spacer(1,10)])
        rows=[['Test','Result','Unit','Illustrative reference interval'],['White blood cells','7.0','x10^3/uL','4.5-13.0'],['Hemoglobin','13.8','g/dL','12.0-16.0'],['Platelets','280','x10^3/uL','150-450'],['Eosinophils, absolute','420','cells/uL','0-500']]
        result=Table(rows,colWidths=[160,65,80,195],hAlign='LEFT')
        result.setStyle(TableStyle([('BACKGROUND',(0,0),(-1,0),colors.HexColor('#dce7f3')),('GRID',(0,0),(-1,-1),0.4,colors.grey),('FONTSIZE',(0,0),(-1,-1),9),('TOPPADDING',(0,0),(-1,-1),8),('BOTTOMPADDING',(0,0),(-1,-1),8)]))
        story.extend([result, Spacer(1,12), Paragraph('Reference intervals are fictional examples, not clinical guidance. Interpret with the ordering care team. This patient copy is not a prescription or an authorization decision.',styles['BodyText']),Spacer(1,12)])
    for text in d['lines']:
        story.extend([Paragraph(escape(text), styles['BodyText']), Spacer(1, 10)])
    story.extend([Spacer(1, 24), Paragraph('Fictional patient: Diego Martinez, age 14. Caregiver: Rosa Martinez. Bergen County, NJ. No real clinician, insurer decision, member identifier or signature is represented. For software demonstration only; no clinical recommendation.', styles['BodyText'])])
    def footer(c, _):
        c.setFillColor(colors.darkred)
        c.setFont('Helvetica', 9)
        c.drawString(42, 25, f'SAMPLE / SYNTHETIC DATA - DEMONSTRATION ONLY                                      Page {c.getPageNumber()}')
    SimpleDocTemplate(str(root / d['file']), topMargin=35, bottomMargin=45).build(story, onFirstPage=footer,onLaterPages=footer)
print('Generated five source PDFs: portal lab, printed lab, mailed denial, prior treatment, urgent visit')
