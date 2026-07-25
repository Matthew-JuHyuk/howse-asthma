"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrPatSettings() {
  return (
    <DialogLayout open={false} onOpenChange={() => {}}>
      <div className="flex h-full w-full items-center justify-center bg-neutral-100 px-6 py-6 mobile:px-0 mobile:py-0">
        <div className="flex flex-col items-start overflow-hidden rounded-[40px] bg-neutral-0 shadow-overlay w-[390px] h-[844px] relative mobile:grow mobile:shrink-0 mobile:basis-0 mobile:self-stretch mobile:rounded-none">
          <div className="flex w-full items-center justify-between px-8 pt-3 pb-1">
            <span className="text-caption font-caption text-neutral-400">
              9:41
            </span>
            <div className="flex items-center gap-1.5">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-4 h-4"
                width="1em"
                height="1em"
                viewBox="0 0 16 16"
              >
                <path
                  d="M1 10h2v4H1zm4-3h2v7H5zm4-3h2v10H9zm4-3h2v13h-2z"
                  fill="currentColor"
                  fillOpacity="1"
                />
              </svg>
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-4 h-4"
                width="1em"
                height="1em"
                viewBox="0 0 16 16"
              >
                <path
                  d="M8 3C5.5 3 3.2 4 1.5 5.7l1.4 1.4C4.3 5.8 6.1 5 8 5s3.7.8 5.1 2.1l1.4-1.4C12.8 4 10.5 3 8 3m0 4c-1.4 0-2.7.6-3.6 1.5L5.8 10c.6-.6 1.4-.9 2.2-.9s1.6.3 2.2.9l1.4-1.5C10.7 7.6 9.4 7 8 7m0 4a1.5 1.5 0 1 0 0 3 1.5 1.5 0 0 0 0-3"
                  fill="currentColor"
                  fillOpacity="1"
                />
              </svg>
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-5 h-3"
                width="1em"
                height="1em"
                viewBox="0 0 22 12"
              >
                <rect
                  x="0"
                  y="1"
                  width="18"
                  height="10"
                  rx="2"
                  ry="2"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.5"
                  strokeLinecap="butt"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <rect
                  x="2"
                  y="3"
                  width="12"
                  height="6"
                  rx="1"
                  ry="1"
                  fill="currentColor"
                  fillOpacity="1"
                />
                <path
                  d="M20 5v2a1.5 1.5 0 0 0 0-2"
                  fill="currentColor"
                  fillOpacity="1"
                />
              </svg>
            </div>
          </div>
          <div className="flex w-full items-center gap-3 px-5 py-3">
            <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-neutral-100 cursor-pointer">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-600 w-5 h-5"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <path
                  d="m15 18-6-6 6-6"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
            </div>
            <div className="flex flex-col items-start flex-1">
              <span className="text-cta font-cta text-default-font">
                Settings
              </span>
              <span className="text-caption font-caption text-neutral-400">
                SCR-PAT-SETTINGS
              </span>
            </div>
            <div className="flex h-9 w-9 flex-none items-center justify-center rounded-lg bg-brand-600">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-5 h-5"
                width="1em"
                height="1em"
                viewBox="0 0 32 32"
              >
                <path
                  d="M16 4C10 4 6 8 6 14c0 4 2 7 4 9l6 5 6-5c2-2 4-5 4-9 0-6-4-10-10-10"
                  fill="currentColor"
                  fillOpacity="1"
                />
                <path d="M14 12h4v8h-4z" fill="rgb(255 255 255)" />
                <path d="M12 16h8v4h-8z" fill="rgb(255 255 255)" />
              </svg>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-6 px-5 pt-1 pb-28 flex-1 overflow-y-auto">
            <div className="flex w-full flex-col items-start gap-3">
              <div className="flex w-full items-center gap-2">
                <div className="flex h-9 w-9 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <ellipse
                      cx="12"
                      cy="12"
                      rx="10"
                      ry="10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M2 12h20"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 2c3 3 5 7 5 10s-2 7-5 10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 2C9 5 7 9 7 12s2 7 5 10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <span className="text-body-bold font-body-bold text-default-font">
                  Language
                </span>
              </div>
              <div className="w-full items-start gap-2.5 grid grid-cols-3">
                <div className="flex items-center justify-center self-stretch rounded-default border-2 border-solid border-brand-600 bg-brand-50 px-3 py-3 cursor-pointer">
                  <span className="text-body-bold font-body-bold text-brand-700">
                    EN
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3 cursor-pointer">
                  <span className="text-body-bold font-body-bold text-neutral-700">
                    ES
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3 cursor-pointer">
                  <span className="text-body-bold font-body-bold text-neutral-700">
                    FR
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3 cursor-pointer">
                  <span className="text-body-bold font-body-bold text-neutral-700">
                    KO
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3 cursor-pointer">
                  <span className="text-body-bold font-body-bold text-neutral-700">
                    JA
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3 cursor-pointer">
                  <span className="text-body-bold font-body-bold text-neutral-700">
                    ZH
                  </span>
                </div>
              </div>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-200" />
            <div className="flex w-full flex-col items-start gap-4">
              <div className="flex w-full items-center gap-2">
                <div className="flex h-9 w-9 flex-none items-center justify-center rounded-lg bg-warning-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M13.73 21a2 2 0 0 1-3.46 0"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <span className="text-body-bold font-body-bold text-default-font">
                  Alert Preferences
                </span>
              </div>
              <div className="flex w-full items-center gap-3 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5">
                <div className="flex h-10 w-10 flex-none items-center justify-center rounded-lg bg-warning-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 9v4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 17h.01"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Risk Alerts
                  </span>
                  <span className="text-caption font-caption text-neutral-500">
                    Score changes and warnings
                  </span>
                </div>
                <div className="flex h-7 w-12 flex-none items-center rounded-full bg-brand-600 px-0.5 cursor-pointer">
                  <div className="flex items-start flex-1" />
                  <div className="flex h-6 w-6 flex-none items-start rounded-full bg-neutral-0 shadow-sm" />
                </div>
              </div>
              <div className="flex w-full items-center gap-3 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5">
                <div className="flex h-10 w-10 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M12 3 2 12h3v8h5v-6h4v6h5v-8h3z"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Home Alerts
                  </span>
                  <span className="text-caption font-caption text-neutral-500">
                    TRAP and pollen at home location
                  </span>
                </div>
                <div className="flex h-7 w-12 flex-none items-center rounded-full bg-brand-600 px-0.5 cursor-pointer">
                  <div className="flex items-start flex-1" />
                  <div className="flex h-6 w-6 flex-none items-start rounded-full bg-neutral-0 shadow-sm" />
                </div>
              </div>
              <div className="flex w-full items-center gap-3 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5">
                <div className="flex h-10 w-10 flex-none items-center justify-center rounded-lg bg-neutral-100">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-500 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7m0 9.5A2.5 2.5 0 0 1 9.5 9 2.5 2.5 0 0 1 12 6.5 2.5 2.5 0 0 1 14.5 9a2.5 2.5 0 0 1-2.5 2.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Travel Alerts
                  </span>
                  <span className="text-caption font-caption text-neutral-500">
                    Air quality when away from home
                  </span>
                </div>
                <div className="flex h-7 w-12 flex-none items-center rounded-full bg-neutral-300 px-0.5 cursor-pointer">
                  <div className="flex h-6 w-6 flex-none items-start rounded-full bg-neutral-0 shadow-sm" />
                </div>
              </div>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-200" />
            <div className="flex w-full flex-col items-start gap-3">
              <div className="flex w-full items-center gap-2">
                <div className="flex h-9 w-9 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 6c-3.31 0-6 2.69-6 6 0 1.66.67 3.16 1.76 4.24"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 10a2 2 0 1 0 2 2"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M18 12c0-3.31-2.69-6-6-6"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M22 12c0-5.52-4.48-10-10-10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <span className="text-body-bold font-body-bold text-default-font">
                  Security
                </span>
              </div>
              <div className="flex w-full items-center gap-3 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5">
                <div className="flex h-10 w-10 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m9 12 2 2 4-4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Biometric Login
                  </span>
                  <span className="text-caption font-caption text-neutral-500">
                    Face ID or fingerprint
                  </span>
                </div>
                <div className="flex h-7 w-12 flex-none items-center rounded-full bg-brand-600 px-0.5 cursor-pointer">
                  <div className="flex items-start flex-1" />
                  <div className="flex h-6 w-6 flex-none items-start rounded-full bg-neutral-0 shadow-sm" />
                </div>
              </div>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-200" />
            <div className="flex w-full flex-col items-start gap-3">
              <div className="flex w-full items-center gap-2">
                <div className="flex h-9 w-9 flex-none items-center justify-center rounded-lg bg-error-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-500 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M22 16.92v3a2 2 0 0 1-2.18 2 19.8 19.8 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.8 19.8 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.362 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.338 1.85.573 2.81.7A2 2 0 0 1 22 16.92"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <span className="text-body-bold font-body-bold text-default-font">
                  Emergency Contact
                </span>
              </div>
              <div className="flex w-full items-center gap-3 rounded-default border border-solid border-error-200 bg-error-50 px-4 py-3.5">
                <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-error-100">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-600 w-6 h-6"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <ellipse
                      cx="12"
                      cy="7"
                      rx="4"
                      ry="4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Carmen Reyes
                  </span>
                  <span className="text-caption font-caption text-neutral-500">
                    (555) 867-5309
                  </span>
                </div>
                <div className="flex h-9 w-9 flex-none items-center justify-center rounded-full bg-neutral-0 cursor-pointer">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-600 w-4.5 h-4.5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4z"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
              </div>
              <span className="text-caption font-caption text-neutral-400">
                One person to call in an emergency
              </span>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-200" />
            <div className="flex w-full flex-col items-start gap-4">
              <div className="flex w-full items-center gap-2">
                <div className="flex h-9 w-9 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <ellipse
                      cx="8.5"
                      cy="7"
                      rx="4"
                      ry="4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M20 8v6"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M23 11h-6"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <span className="text-body-bold font-body-bold text-default-font">
                  Provider Pairing
                </span>
              </div>
              <span className="text-caption font-caption text-neutral-500">
                Enter 6-digit invite code from your provider
              </span>
              <div className="flex w-full items-center justify-center gap-2.5">
                <div className="flex h-14 w-12 flex-none items-center justify-center rounded-md border-2 border-solid border-brand-600 bg-brand-50">
                  <span className="text-heading-1 font-heading-1 text-brand-700">
                    4
                  </span>
                </div>
                <div className="flex h-14 w-12 flex-none items-center justify-center rounded-md border-2 border-solid border-brand-600 bg-brand-50">
                  <span className="text-heading-1 font-heading-1 text-brand-700">
                    8
                  </span>
                </div>
                <div className="flex h-14 w-12 flex-none items-center justify-center rounded-md border-2 border-solid border-brand-300 bg-neutral-0">
                  <span className="text-heading-1 font-heading-1 text-neutral-300">
                    -
                  </span>
                </div>
                <div className="flex h-14 w-12 flex-none items-center justify-center rounded-md border border-solid border-neutral-200 bg-neutral-0">
                  <span className="text-heading-1 font-heading-1 text-neutral-300">
                    -
                  </span>
                </div>
                <div className="flex h-14 w-12 flex-none items-center justify-center rounded-md border border-solid border-neutral-200 bg-neutral-0">
                  <span className="text-heading-1 font-heading-1 text-neutral-300">
                    -
                  </span>
                </div>
                <div className="flex h-14 w-12 flex-none items-center justify-center rounded-md border border-solid border-neutral-200 bg-neutral-0">
                  <span className="text-heading-1 font-heading-1 text-neutral-300">
                    -
                  </span>
                </div>
              </div>
              <div className="w-full items-start gap-2.5 grid grid-cols-3 max-w-[280px] mx-auto">
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    1
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    2
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    3
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    4
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    5
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    6
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    7
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    8
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    9
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md py-3.5" />
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <span className="text-heading-2 font-heading-2 text-default-font">
                    0
                  </span>
                </div>
                <div className="flex items-center justify-center self-stretch rounded-md bg-neutral-50 py-3.5 cursor-pointer">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-600 w-6 h-6"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M21 4H8l-7 8 7 8h13a2 2 0 0 0 2-2V6a2 2 0 0 0-2-2"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m18 9-6 6"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m12 9 6 6"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
              </div>
              <div className="flex w-full items-center justify-center gap-2 rounded-md bg-brand-50 px-3 py-2">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-500 w-3.5 h-3.5 flex-none"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="m9 12 2 2 4-4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-brand-700">
                  Paired with Dr. Martinez
                </span>
              </div>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-200" />
            <div className="flex w-full flex-col items-start gap-3 pb-4">
              <div className="flex w-full items-center justify-center gap-2.5 rounded-default border border-solid border-error-200 bg-error-50 px-5 py-4 cursor-pointer">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-600 w-5 h-5"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="m16 17 5-5-5-5"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M21 12H9"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-cta font-cta text-error-600">
                  Log Out
                </span>
              </div>
              <span className="w-full text-caption font-caption text-neutral-400 text-center">
                Howse Asthma v1.0.0
              </span>
            </div>
          </div>
          <div className="flex flex-col items-center border-t border-solid border-neutral-200 bg-neutral-0 absolute bottom-0 left-0 right-0">
            <div className="flex w-full px-2 pt-2.5 pb-7 items-end justify-around">
              <div className="flex flex-col items-center gap-1 px-3 py-1 cursor-pointer">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M12 3 2 12h3v8h5v-6h4v6h5v-8h3z"
                    fill="currentColor"
                    fillOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-neutral-400">
                  Home
                </span>
              </div>
              <div className="flex flex-col items-center gap-1 px-3 py-1 cursor-pointer">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M14 2v6h6"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M16 13H8"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M16 17H8"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M10 9H8"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-neutral-400">
                  Log
                </span>
              </div>
              <div className="flex flex-col items-center gap-1 px-3 py-1 cursor-pointer">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M18 20V10"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M12 20V4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M6 20v-6"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-neutral-400">
                  Report
                </span>
              </div>
              <div className="flex flex-col items-center gap-1 px-3 py-1 cursor-pointer">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <ellipse
                    cx="12"
                    cy="8"
                    rx="6"
                    ry="6"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-neutral-400">
                  Rewards
                </span>
              </div>
              <div className="flex flex-col items-center gap-1 px-3 py-1 cursor-pointer">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <ellipse
                    cx="12"
                    cy="12"
                    rx="3"
                    ry="3"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.9 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.9.33 1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-brand-600">
                  Settings
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </DialogLayout>
  );
}

export default ScrPatSettings;
