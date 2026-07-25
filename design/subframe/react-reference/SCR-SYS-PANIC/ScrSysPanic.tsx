"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrSysPanic() {
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
        <div className="flex w-full flex-col items-center gap-8 px-6 pt-6 pb-10 flex-1 max-w-[420px]">
          <div className="flex w-full flex-col items-center gap-5">
            <div className="flex items-center gap-2.5">
              <div className="flex h-9 w-9 flex-none items-center justify-center rounded-full bg-error-600">
                <span className="text-cta font-cta text-neutral-0">1</span>
              </div>
              <span className="text-heading-2 font-heading-2 text-neutral-0">
                Breathe &amp; Use Inhaler
              </span>
            </div>
            <div className="flex w-full flex-col items-center gap-4 rounded-lg border-2 border-solid border-error-500 bg-error-900 px-5 py-6">
              <div className="flex h-20 w-20 flex-none items-center justify-center rounded-full bg-error-600">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-10 h-10"
                  width="1em"
                  height="1em"
                  viewBox="0 0 40 40"
                >
                  <ellipse
                    cx="20"
                    cy="20"
                    rx="12"
                    ry="12"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M20 12v8"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M20 24v4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M14 20h12"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                </svg>
              </div>
              <span className="text-cta font-cta text-neutral-0 text-center">
                Slow breath in, slow breath out
              </span>
              <span className="text-body font-body text-error-200 text-center">
                4 seconds in — 4 seconds out
              </span>
            </div>
            <div className="flex w-full items-center justify-center gap-4 rounded-lg bg-error-500 px-6 py-6 shadow-lg cursor-pointer">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-12 h-12 flex-none"
                width="1em"
                height="1em"
                viewBox="0 0 48 48"
              >
                <rect
                  x="18"
                  y="4"
                  width="12"
                  height="24"
                  rx="6"
                  ry="6"
                  fill="currentColor"
                  fillOpacity="1"
                />
                <path
                  d="M15 22a9 9 0 0 0 18 0"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="3"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <path
                  d="M24 33v6"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="3"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <path
                  d="M18 39h12"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="3"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
              </svg>
              <span className="text-heading-2 font-heading-2 text-neutral-0">
                Take Inhaler Now
              </span>
            </div>
          </div>
          <div className="flex w-full items-center gap-3">
            <div className="flex h-px items-start bg-error-700 flex-1" />
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-400 w-5 h-5 flex-none"
              width="1em"
              height="1em"
              viewBox="0 0 24 24"
            >
              <path
                d="M12 5v14"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="m19 12-7 7-7-7"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeOpacity="1"
              />
            </svg>
            <div className="flex h-px items-start bg-error-700 flex-1" />
          </div>
          <div className="flex w-full flex-col items-center gap-5">
            <div className="flex items-center gap-2.5">
              <div className="flex h-9 w-9 flex-none items-center justify-center rounded-full bg-error-600">
                <span className="text-cta font-cta text-neutral-0">2</span>
              </div>
              <span className="text-heading-2 font-heading-2 text-neutral-0">
                Call for Help
              </span>
            </div>
            <div className="flex w-full items-center gap-4 rounded-lg border-2 border-solid border-error-400 bg-error-800 px-5 py-5 cursor-pointer">
              <div className="flex h-16 w-16 flex-none items-center justify-center rounded-full bg-error-600">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-8 h-8"
                  width="1em"
                  height="1em"
                  viewBox="0 0 32 32"
                >
                  <ellipse
                    cx="16"
                    cy="11"
                    rx="5"
                    ry="5"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M7 27c0-5 4-9 9-9s9 4 9 9"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                </svg>
              </div>
              <div className="flex flex-col items-start gap-1 flex-1">
                <span className="text-heading-2 font-heading-2 text-neutral-0">
                  Call Caregiver
                </span>
                <span className="text-body font-body text-error-200">
                  Phone call only
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
            <div className="flex w-full items-center gap-4 rounded-lg bg-error-500 px-5 py-5 shadow-lg cursor-pointer">
              <div className="flex h-16 w-16 flex-none items-center justify-center rounded-full bg-neutral-0">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-600 w-8 h-8"
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
                  <path
                    d="M14 12h4v4h-4z"
                    fill="currentColor"
                    fillOpacity="1"
                  />
                </svg>
              </div>
              <div className="flex flex-col items-start gap-1 flex-1">
                <span className="text-heading-1 font-heading-1 text-neutral-0">
                  Call 911
                </span>
                <span className="text-body font-body text-error-100">
                  Emergency services
                </span>
              </div>
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-9 h-9 flex-none"
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
          <div className="flex w-full items-center justify-center gap-2 pt-2 pb-4">
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

export default ScrSysPanic;
