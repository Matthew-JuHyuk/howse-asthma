"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrAuth04() {
  return (
    <DialogLayout open={false} onOpenChange={() => {}}>
      <div className="flex w-full flex-col items-center justify-between px-8 py-12 gap-12 mobile:px-6 mobile:py-10">
        <div className="flex h-8 flex-none items-start" />
        <div className="flex flex-col items-center gap-8">
          <div className="flex h-32 w-32 flex-none items-center justify-center rounded-full bg-brand-50">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 h-16 w-16"
              width="1em"
              height="1em"
              viewBox="0 0 64 64"
            >
              <path
                d="M32 4C16.536 4 4 16.536 4 32s12.536 28 28 28"
                fill="none"
                stroke="currentColor"
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M32 12c-11.046 0-20 8.954-20 20s8.954 20 20 20"
                fill="none"
                stroke="currentColor"
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M32 20c-6.627 0-12 5.373-12 12 0 3.314 1.343 6.314 3.515 8.485"
                fill="none"
                stroke="currentColor"
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M32 28a4 4 0 1 0 4 4"
                fill="none"
                stroke="currentColor"
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M32 20c6.627 0 12 5.373 12 12 0 4.418-2.388 8.278-5.944 10.362"
                fill="none"
                stroke="currentColor"
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M52 32c0-11.046-8.954-20-20-20"
                fill="none"
                stroke="currentColor"
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M60 32C60 16.536 47.464 4 32 4"
                fill="none"
                stroke="currentColor"
                strokeWidth="3"
                strokeLinecap="round"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <ellipse
                cx="32"
                cy="32"
                rx="2"
                ry="2"
                fill="currentColor"
                fillOpacity="1"
              />
            </svg>
          </div>
          <div className="flex flex-col items-center gap-3">
            <span className="text-heading-2 font-heading-2 text-default-font text-center">
              Unlock Howse Asthma
            </span>
            <span className="text-body font-body text-neutral-500 text-center">
              Use biometrics to continue
            </span>
          </div>
          <div className="flex items-center gap-3">
            <div className="flex h-10 w-10 flex-none items-center justify-center rounded-md bg-brand-100">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 h-5 w-5"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <rect
                  x="3"
                  y="3"
                  width="18"
                  height="18"
                  rx="4"
                  ry="4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.5"
                  strokeLinecap="butt"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <ellipse
                  cx="9"
                  cy="10"
                  rx="1.25"
                  ry="1.25"
                  fill="currentColor"
                  fillOpacity="1"
                />
                <ellipse
                  cx="15"
                  cy="10"
                  rx="1.25"
                  ry="1.25"
                  fill="currentColor"
                  fillOpacity="1"
                />
                <path
                  d="M9.5 15c1 1.5 4 1.5 5 0"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.5"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
              </svg>
            </div>
            <span className="text-caption font-caption text-neutral-400">
              Touch sensor or look at camera
            </span>
          </div>
        </div>
        <div className="flex flex-col items-center gap-4 pb-4">
          <div className="flex h-px w-48 flex-none items-start bg-neutral-200" />
          <span className="text-body font-body text-brand-600 text-center cursor-pointer">
            Use password instead
          </span>
        </div>
      </div>
    </DialogLayout>
  );
}

export default ScrAuth04;
