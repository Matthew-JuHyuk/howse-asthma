"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrSysPanic_Step2() {
  return (
    <DialogLayout open={false} onOpenChange={() => {}}>
      <div className="flex w-full flex-col items-center bg-neutral-900 min-h-[100dvh]">
        <div className="flex w-full items-center justify-center gap-3 bg-error-600 px-6 py-4">
          <svg
            className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-7 h-7 flex-none"
            width="1em"
            height="1em"
            viewBox="0 0 24 24"
          >
            <path
              d="M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeOpacity="1"
            />
            <path
              d="M12 9v4"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="miter"
              strokeOpacity="1"
            />
            <path
              d="M12 17h.01"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="miter"
              strokeOpacity="1"
            />
          </svg>
          <span className="text-cta font-cta text-neutral-0">EMERGENCY</span>
          <svg
            className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-7 h-7 flex-none"
            width="1em"
            height="1em"
            viewBox="0 0 24 24"
          >
            <path
              d="M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeOpacity="1"
            />
            <path
              d="M12 9v4"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="miter"
              strokeOpacity="1"
            />
            <path
              d="M12 17h.01"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="miter"
              strokeOpacity="1"
            />
          </svg>
        </div>
        <div className="flex w-full flex-col items-center gap-6 px-6 pt-6 pb-12 flex-1 max-w-[420px]">
          <div className="flex w-full items-center justify-center gap-3">
            <div className="flex items-center gap-2">
              <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full border border-solid border-error-600 bg-error-800">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-300 w-4 h-4"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="m9 12 2 2 4-4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
              </div>
              <span className="text-caption font-caption text-error-400">
                Breathe
              </span>
            </div>
            <div className="flex h-px w-6 flex-none items-start bg-error-700" />
            <div className="flex items-center gap-2">
              <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-error-600">
                <span className="text-body-bold font-body-bold text-neutral-0">
                  2
                </span>
              </div>
              <span className="text-body-bold font-body-bold text-neutral-0">
                Call for Help
              </span>
            </div>
          </div>
          <div className="flex w-full flex-col items-center gap-3 pt-2">
            <div className="flex h-20 w-20 flex-none items-center justify-center rounded-full bg-error-600">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-10 h-10"
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
            <span className="text-heading-1 font-heading-1 text-neutral-0 text-center">
              Call for Help Now
            </span>
            <span className="text-body font-body text-error-200 text-center">
              Tap to place a phone call
            </span>
          </div>
          <div className="flex min-h-[24px] items-start flex-1" />
          <div className="flex w-full flex-col items-center gap-3">
            <div className="flex w-full items-center gap-5 rounded-lg bg-error-500 px-6 py-6 shadow-lg cursor-pointer">
              <div className="flex h-20 w-20 flex-none items-center justify-center rounded-full bg-neutral-0">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-600 w-10 h-10"
                  width="1em"
                  height="1em"
                  viewBox="0 0 40 40"
                >
                  <ellipse
                    cx="20"
                    cy="13"
                    rx="6"
                    ry="6"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M9 33c0-6 5-11 11-11s11 5 11 11"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
              </div>
              <div className="flex flex-col items-start gap-1.5 flex-1">
                <span className="text-heading-1 font-heading-1 text-neutral-0">
                  Call Caregiver
                </span>
                <span className="text-body font-body text-error-100">
                  Phone call only
                </span>
              </div>
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-10 h-10 flex-none"
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
          </div>
          <div className="flex w-full items-center gap-5 rounded-lg border-2 border-solid border-error-400 bg-error-900 px-6 py-5 cursor-pointer">
            <div className="flex h-16 w-16 flex-none items-center justify-center rounded-full bg-error-600">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-8 h-8"
                width="1em"
                height="1em"
                viewBox="0 0 32 32"
              >
                <path
                  d="M16 4 6 12h2v12h6v-6h4v6h6V12h2z"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
                <path d="M14 12h4v4h-4z" fill="currentColor" fillOpacity="1" />
              </svg>
            </div>
            <div className="flex flex-col items-start gap-1 flex-1">
              <span className="text-heading-2 font-heading-2 text-neutral-0">
                Call 911
              </span>
              <span className="text-body font-body text-error-200">
                Emergency services
              </span>
            </div>
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-300 w-8 h-8 flex-none"
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
          <div className="flex w-full items-center gap-3">
            <div className="flex h-px items-start bg-error-800 flex-1" />
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-500 w-4 h-4 flex-none"
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
                d="M12 16v-4"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M12 8h.01"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
            </svg>
            <div className="flex h-px items-start bg-error-800 flex-1" />
          </div>
          <div className="flex w-full flex-col items-center gap-3 rounded-lg border border-solid border-error-800 bg-error-900 px-5 py-4">
            <div className="flex w-full items-start gap-3">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-400 w-5 h-5 mt-0.5 flex-none"
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
              </svg>
              <div className="flex flex-col items-start gap-2 flex-1">
                <span className="text-body-bold font-body-bold text-error-200">
                  This app does not auto-dial
                </span>
                <span className="text-caption font-caption text-error-300">
                  You must tap to place the call yourself. No SMS, push, or
                  email alerts are sent automatically.
                </span>
              </div>
            </div>
          </div>
          <div className="flex w-full items-center justify-center gap-2 pt-1 pb-4">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-400 w-4 h-4 flex-none"
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
            </svg>
            <span className="text-caption font-caption text-error-300">
              Stay calm — help is available
            </span>
          </div>
        </div>
      </div>
    </DialogLayout>
  );
}

export default ScrSysPanic_Step2;
