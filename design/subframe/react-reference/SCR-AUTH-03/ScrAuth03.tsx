"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrAuth03() {
  return (
    <DialogLayout open={false} onOpenChange={() => {}}>
      <div className="flex flex-col items-start overflow-hidden rounded-lg bg-neutral-0 w-[390px] h-[820px] relative mobile:h-full mobile:w-full">
        <div className="flex w-full flex-col items-start gap-6 px-6 pt-10 pb-28 flex-1 overflow-y-auto">
          <div className="flex w-full items-center gap-2">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-7 h-7"
              width="1em"
              height="1em"
              viewBox="0 0 28 28"
            >
              <ellipse
                cx="14"
                cy="14"
                rx="13"
                ry="13"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="butt"
                strokeLinejoin="miter"
                strokeOpacity="1"
              />
              <path
                d="M9 18v-8h2v3h6v-3h2v8h-2v-3h-6v3z"
                fill="currentColor"
                fillOpacity="1"
              />
            </svg>
            <span className="text-cta font-cta text-brand-700">
              Howse Asthma
            </span>
          </div>
          <div className="flex w-full items-center gap-2">
            <div className="flex h-1 w-8 flex-none items-start rounded-full bg-brand-500" />
            <div className="flex h-1 w-8 flex-none items-start rounded-full bg-brand-200" />
            <div className="flex h-1 w-8 flex-none items-start rounded-full bg-neutral-200" />
            <div className="flex h-1 w-8 flex-none items-start rounded-full bg-neutral-200" />
          </div>
          <span className="w-full text-heading-2 font-heading-2 text-default-font">
            Choose your role
          </span>
          <div className="flex w-full items-start gap-4">
            <div className="flex flex-col items-center gap-3 self-stretch rounded-lg border-2 border-solid border-neutral-200 bg-neutral-50 px-5 py-5 flex-1 cursor-pointer">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-16 h-16"
                width="1em"
                height="1em"
                viewBox="0 0 64 64"
              >
                <ellipse
                  cx="32"
                  cy="20"
                  rx="9"
                  ry="9"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="butt"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <path
                  d="M16 52c0-8.837 7.163-16 16-16s16 7.163 16 16"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <path
                  d="M24 42v10h-6l-2-8 4-6h4z"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.5"
                  strokeLinecap="butt"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <rect
                  x="38"
                  y="40"
                  width="12"
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
                <path
                  d="M41 44h6m-6 3h4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
              </svg>
              <span className="text-body-bold font-body-bold text-neutral-500">
                Patient
              </span>
            </div>
            <div className="flex flex-col items-center gap-3 self-stretch rounded-lg border-2 border-solid border-brand-600 bg-brand-50 px-5 py-5 shadow-md flex-1 cursor-pointer">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-16 h-16"
                width="1em"
                height="1em"
                viewBox="0 0 64 64"
              >
                <ellipse
                  cx="26"
                  cy="18"
                  rx="8"
                  ry="8"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="butt"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <path
                  d="M12 48c0-7.732 6.268-14 14-14s14 6.268 14 14"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <path
                  d="M24 12v-2m4 2v-2m-4 0h4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.5"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <rect
                  x="38"
                  y="22"
                  width="18"
                  height="24"
                  rx="3"
                  ry="3"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="butt"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <path
                  d="M42 30h10m-10 4h10m-10 4h6"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.5"
                  strokeLinecap="round"
                  strokeLinejoin="miter"
                  strokeOpacity="1"
                />
                <ellipse
                  cx="47"
                  cy="42"
                  rx="1.5"
                  ry="1.5"
                  fill="currentColor"
                  fillOpacity="1"
                />
              </svg>
              <span className="text-body-bold font-body-bold text-brand-700">
                Provider
              </span>
              <div className="flex h-5 w-5 flex-none items-center justify-center rounded-full bg-brand-600">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-3 h-3"
                  width="1em"
                  height="1em"
                  viewBox="0 0 16 16"
                >
                  <path
                    d="m3 8 4 4 6-7"
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
          </div>
          <div className="flex w-full flex-col items-start gap-5 pt-2">
            <div className="flex w-full flex-col items-start gap-1.5">
              <span className="w-full text-caption font-caption text-neutral-600">
                Full Name
              </span>
              <div className="flex h-12 w-full flex-none items-center rounded-md border border-solid border-neutral-300 bg-neutral-0 px-4">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-5 h-5 mr-3"
                  width="1em"
                  height="1em"
                  viewBox="0 0 20 20"
                >
                  <ellipse
                    cx="10"
                    cy="7"
                    rx="4"
                    ry="4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="butt"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M3 18a7 7 0 1 1 14 0"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-body font-body text-neutral-400">
                  Dr. Jane Smith
                </span>
              </div>
            </div>
            <div className="flex w-full flex-col items-start gap-2">
              <span className="w-full text-caption font-caption text-neutral-600">
                Language
              </span>
              <div className="flex w-full flex-wrap items-start gap-2">
                <div className="flex h-10 items-center justify-center rounded-full bg-brand-600 px-4 cursor-pointer">
                  <span className="text-body-bold font-body-bold text-neutral-0">
                    EN
                  </span>
                </div>
                <div className="flex h-10 items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0 px-4 cursor-pointer">
                  <span className="text-body font-body text-neutral-600">
                    ES
                  </span>
                </div>
                <div className="flex h-10 items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0 px-4 cursor-pointer">
                  <span className="text-body font-body text-neutral-600">
                    FR
                  </span>
                </div>
                <div className="flex h-10 items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0 px-4 cursor-pointer">
                  <span className="text-body font-body text-neutral-600">
                    KO
                  </span>
                </div>
                <div className="flex h-10 items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0 px-4 cursor-pointer">
                  <span className="text-body font-body text-neutral-600">
                    JA
                  </span>
                </div>
                <div className="flex h-10 items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0 px-4 cursor-pointer">
                  <span className="text-body font-body text-neutral-600">
                    ZH
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full flex-col items-start gap-1.5">
              <div className="flex w-full items-center gap-1.5">
                <span className="text-caption font-caption text-neutral-600">
                  NPI Number
                </span>
                <div className="flex items-center justify-center rounded-sm bg-brand-100 px-1.5 py-0.5">
                  <span className="font-['Inter'] text-[11px] font-[400] leading-[16.5px] text-brand-700">
                    Provider
                  </span>
                </div>
              </div>
              <div className="flex h-12 w-full flex-none items-center rounded-md border border-solid border-neutral-300 bg-neutral-0 px-4">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-5 h-5 mr-3"
                  width="1em"
                  height="1em"
                  viewBox="0 0 20 20"
                >
                  <rect
                    x="2"
                    y="4"
                    width="16"
                    height="12"
                    rx="2"
                    ry="2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="butt"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M6 9h2m-2 3h4m2-3h2m-2 3h2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-body font-body text-neutral-400">
                  10-digit NPI
                </span>
              </div>
              <span className="w-full text-caption font-caption text-neutral-400">
                Required for healthcare provider verification
              </span>
            </div>
            <div className="flex w-full flex-col items-start gap-1.5">
              <span className="w-full text-caption font-caption text-neutral-600">
                Password
              </span>
              <div className="flex h-12 w-full flex-none items-center rounded-md border border-solid border-neutral-300 bg-neutral-0 px-4">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-5 h-5 mr-3"
                  width="1em"
                  height="1em"
                  viewBox="0 0 20 20"
                >
                  <rect
                    x="4"
                    y="9"
                    width="12"
                    height="8"
                    rx="2"
                    ry="2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="butt"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M7 9V6a3 3 0 0 1 6 0v3"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <ellipse
                    cx="10"
                    cy="13"
                    rx="1.5"
                    ry="1.5"
                    fill="currentColor"
                    fillOpacity="1"
                  />
                </svg>
                <span className="text-body font-body text-neutral-400">
                  Create password
                </span>
              </div>
              <div className="flex w-full items-center gap-3 pt-1">
                <div className="flex h-1 items-start rounded-full bg-brand-400 flex-1" />
                <div className="flex h-1 items-start rounded-full bg-brand-400 flex-1" />
                <div className="flex h-1 items-start rounded-full bg-neutral-200 flex-1" />
                <div className="flex h-1 items-start rounded-full bg-neutral-200 flex-1" />
              </div>
            </div>
          </div>
        </div>
        <div className="flex flex-col items-start gap-3 px-6 pt-4 pb-8 absolute bottom-0 left-0 right-0 bg-gradient-to-t from-neutral-0 via-neutral-0 to-transparent">
          <div className="flex h-14 w-full flex-none items-center justify-center rounded-lg bg-brand-600 shadow-md cursor-pointer">
            <span className="text-cta font-cta text-neutral-0">Continue</span>
          </div>
          <div className="flex w-full items-center justify-center">
            <span className="text-caption font-caption text-neutral-400">
              Already have an account? Sign in
            </span>
          </div>
        </div>
      </div>
    </DialogLayout>
  );
}

export default ScrAuth03;
