"use client";

import React from "react";

function ScrAuth02() {
  return (
    <div className="flex h-full w-full flex-col items-center bg-neutral-0">
      <div className="flex w-full grow shrink-0 basis-0 flex-col items-center justify-between px-6 pt-16 pb-8 max-w-[390px] mobile:px-5 mobile:pt-12">
        <div className="flex w-full flex-col items-center gap-10">
          <div className="flex flex-col items-center gap-3">
            <div className="flex h-14 w-14 flex-none items-center justify-center rounded-lg bg-brand-100">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-[#171717]"
                width="1em"
                height="1em"
                viewBox="0 0 32 32"
              >
                <path
                  d="M16 4s-4 4-4 10c0 2 1 4 2 5-2 .5-4 2-5 4s-.5 4 1 5 4 0 5-2c.5-1 1-3 1-4"
                  fill="none"
                  stroke="rgb(15 118 110)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M16 4s4 4 4 10c0 2-1 4-2 5 2 .5 4 2 5 4s.5 4-1 5-4 0-5-2c-.5-1-1-3-1-4"
                  fill="none"
                  stroke="rgb(15 118 110)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M16 4v18"
                  fill="none"
                  stroke="rgb(15 118 110)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                />
              </svg>
            </div>
            <span className="text-cta font-cta text-brand-700">
              Howse Asthma
            </span>
          </div>
          <div className="flex w-full flex-col gap-5 items-stretch">
            <div className="flex w-full flex-col items-start gap-1.5">
              <span className="text-caption font-caption text-neutral-600">
                Email
              </span>
              <div className="flex w-full items-center gap-3 rounded-md border border-solid border-neutral-300 bg-neutral-0 px-4 py-3.5">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-[#171717]"
                  width="1em"
                  height="1em"
                  viewBox="0 0 20 20"
                >
                  <path
                    d="m3 5 7 6 7-6"
                    fill="none"
                    stroke="rgb(148 163 184)"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <rect
                    x="2"
                    y="4"
                    width="16"
                    height="12"
                    rx="2"
                    ry="2"
                    fill="none"
                    stroke="rgb(148 163 184)"
                    strokeWidth="1.5"
                    strokeLinecap="butt"
                    strokeLinejoin="miter"
                  />
                </svg>
                <span className="text-body font-body text-neutral-400">
                  you@example.com
                </span>
              </div>
            </div>
            <div className="flex w-full flex-col items-start gap-1.5">
              <span className="text-caption font-caption text-neutral-600">
                Password
              </span>
              <div className="flex w-full items-center gap-3 rounded-md border border-solid border-neutral-300 bg-neutral-0 px-4 py-3.5">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-[#171717]"
                  width="1em"
                  height="1em"
                  viewBox="0 0 20 20"
                >
                  <rect
                    x="4"
                    y="9"
                    width="12"
                    height="9"
                    rx="2"
                    ry="2"
                    fill="none"
                    stroke="rgb(148 163 184)"
                    strokeWidth="1.5"
                    strokeLinecap="butt"
                    strokeLinejoin="miter"
                  />
                  <path
                    d="M7 9V6c0-2.21 1.79-4 3-4s3 1.79 3 4v3"
                    fill="none"
                    stroke="rgb(148 163 184)"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                  />
                  <ellipse
                    cx="10"
                    cy="14"
                    rx="1.5"
                    ry="1.5"
                    fill="rgb(148 163 184)"
                  />
                </svg>
                <span className="text-body font-body text-neutral-400">
                  ••••••••
                </span>
              </div>
            </div>
            <div className="flex w-full items-center justify-end">
              <span className="text-caption font-caption text-brand-600">
                Forgot password?
              </span>
            </div>
          </div>
        </div>
        <div className="flex w-full flex-col items-center gap-5 pt-6">
          <div className="flex w-full items-center justify-center rounded-md bg-brand-600 px-6 py-4 shadow-sm">
            <span className="text-cta font-cta text-neutral-0">Log in</span>
          </div>
          <div className="flex items-center gap-1">
            <span className="text-body font-body text-neutral-500">
              No account?
            </span>
            <span className="text-body-bold font-body-bold text-brand-600">
              Sign up
            </span>
          </div>
          <div className="flex w-full items-center gap-3">
            <div className="flex h-px grow shrink-0 basis-0 items-start bg-neutral-200" />
            <span className="text-caption font-caption text-neutral-400">
              or continue with
            </span>
            <div className="flex h-px grow shrink-0 basis-0 items-start bg-neutral-200" />
          </div>
          <div className="flex w-full items-center justify-center gap-3">
            <div className="flex grow shrink-0 basis-0 items-center justify-center gap-2.5 rounded-md border border-solid border-neutral-200 bg-neutral-0 px-5 py-3.5 shadow-sm">
              <span className="text-body-bold font-body-bold text-neutral-700">
                Google
              </span>
            </div>
            <div className="flex grow shrink-0 basis-0 items-center justify-center gap-2.5 rounded-md border border-solid border-neutral-200 bg-neutral-0 px-5 py-3.5 shadow-sm">
              <span className="text-body-bold font-body-bold text-neutral-700">
                Apple
              </span>
            </div>
          </div>
          <div className="flex items-center gap-2 pb-2">
            <span className="text-caption font-caption text-neutral-500">
              Use Face ID or fingerprint to unlock
            </span>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ScrAuth02;
