"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrSysAlert() {
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
          <div className="flex w-full items-center justify-center gap-2.5 bg-warning-600 px-6 py-3.5">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-6 h-6 flex-none"
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
            <span className="text-cta font-cta text-neutral-0">RISK ALERT</span>
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-6 h-6 flex-none"
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
          <div className="flex w-full flex-col items-start gap-5 px-5 pt-5 pb-48 flex-1 overflow-y-auto">
            <div className="flex w-full flex-col items-start gap-1">
              <span className="text-heading-2 font-heading-2 text-default-font">
                Environmental Alert
              </span>
              <span className="text-body font-body text-subtext-color">
                Active risk conditions in your area
              </span>
            </div>
            <div className="flex w-full flex-col items-start gap-4 rounded-default border-2 border-solid border-warning-400 bg-warning-50 px-4 py-5 shadow-md">
              <div className="flex w-full items-start gap-3.5">
                <div className="flex h-14 w-14 flex-none items-center justify-center rounded-lg bg-warning-100">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-8 h-8"
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
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 3v3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 18v3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M3 12h3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M18 12h3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m5.6 5.6 2.1 2.1"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m16.3 16.3 2.1 2.1"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m5.6 18.4 2.1-2.1"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m16.3 7.7 2.1-2.1"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-1 flex-1">
                  <div className="flex w-full items-center justify-between">
                    <span className="text-cta font-cta text-default-font">
                      Pollen
                    </span>
                    <div className="flex items-center gap-1.5 rounded-full bg-warning-200 px-3 py-1">
                      <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-warning-500" />
                      <span className="text-caption font-caption text-warning-800">
                        High
                      </span>
                    </div>
                  </div>
                  <span className="text-body font-body text-warning-800">
                    Tree pollen is elevated in your area
                  </span>
                </div>
              </div>
              <div className="flex w-full items-center gap-1">
                <div className="flex h-2 items-start rounded-full bg-warning-400 flex-1" />
                <div className="flex h-2 items-start rounded-full bg-warning-400 flex-1" />
                <div className="flex h-2 items-start rounded-full bg-warning-400 flex-1" />
                <div className="flex h-2 items-start rounded-full bg-warning-300 flex-1" />
                <div className="flex h-2 items-start rounded-full bg-neutral-200 flex-1" />
              </div>
              <div className="flex w-full items-start gap-3 rounded-md bg-warning-100 px-3.5 py-3">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-5 h-5 mt-0.5 flex-none"
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
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <ellipse
                    cx="12"
                    cy="17"
                    rx="0.5"
                    ry="0.5"
                    fill="currentColor"
                    fillOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-warning-900 flex-1">
                  Limit outdoor activity between 10 AM and 4 PM. Close windows
                  and use your rescue inhaler if needed.
                </span>
              </div>
            </div>
            <div className="flex w-full flex-col items-start gap-3">
              <span className="text-body-bold font-body-bold text-default-font">
                What to Do
              </span>
              <div className="flex w-full flex-wrap items-start gap-2.5">
                <div className="flex items-center gap-2 rounded-full border border-solid border-warning-300 bg-warning-50 px-4 py-2.5">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-4.5 h-4.5 flex-none"
                    width="1em"
                    height="1em"
                    viewBox="0 0 20 20"
                  >
                    <path
                      d="M10 2 2 9h2v7h5v-4h2v4h5V9h2z"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-warning-800">
                    Stay Indoors
                  </span>
                </div>
                <div className="flex items-center gap-2 rounded-full border border-solid border-warning-300 bg-warning-50 px-4 py-2.5">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-4.5 h-4.5 flex-none"
                    width="1em"
                    height="1em"
                    viewBox="0 0 20 20"
                  >
                    <rect
                      x="2"
                      y="3"
                      width="16"
                      height="14"
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
                      d="M6 7h8m-8 3h5"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M2 10h6l-2 4h4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-warning-800">
                    Close Windows
                  </span>
                </div>
                <div className="flex items-center gap-2 rounded-full border border-solid border-brand-300 bg-brand-50 px-4 py-2.5">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4.5 h-4.5 flex-none"
                    width="1em"
                    height="1em"
                    viewBox="0 0 20 20"
                  >
                    <rect
                      x="7"
                      y="2"
                      width="6"
                      height="12"
                      rx="3"
                      ry="3"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <path
                      d="M5.5 10.5c0 2.5 2 4.5 4.5 4.5s4.5-2 4.5-4.5"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M10 16v2"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M8 18h4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-brand-700">
                    Rescue Inhaler
                  </span>
                </div>
                <div className="flex items-center gap-2 rounded-full border border-solid border-brand-300 bg-brand-50 px-4 py-2.5">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4.5 h-4.5 flex-none"
                    width="1em"
                    height="1em"
                    viewBox="0 0 20 20"
                  >
                    <path
                      d="M10 18s6-3 6-7.5V5l-6-2.5L4 5v5.5C4 15 10 18 10 18"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m7 10 2 2 4-4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-brand-700">
                    Stay Calm
                  </span>
                </div>
              </div>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-200" />
            <div className="flex w-full flex-col items-start gap-3">
              <div className="flex w-full items-center gap-2">
                <span className="text-body-bold font-body-bold text-neutral-700">
                  Other Conditions
                </span>
                <div className="flex h-px items-start bg-neutral-200 flex-1" />
              </div>
              <div className="flex w-full items-start gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-4 shadow-sm">
                <div className="flex h-11 w-11 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M3 21h18"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M5 21V7l3-4h8l3 4v14"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M9 21v-6h6v6"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M2 11h20"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M7 11v3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 11v3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M17 11v3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-1 flex-1">
                  <div className="flex w-full items-center justify-between">
                    <span className="text-body-bold font-body-bold text-default-font">
                      TRAP
                    </span>
                    <div className="flex items-center gap-1.5">
                      <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-brand-400" />
                      <span className="text-caption font-caption text-brand-600">
                        Low
                      </span>
                    </div>
                  </div>
                  <span className="text-caption font-caption text-subtext-color">
                    Air-quality proxy — not truck counts
                  </span>
                  <div className="flex w-full items-center gap-1 pt-1.5">
                    <div className="flex h-1.5 items-start rounded-full bg-brand-400 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                  </div>
                </div>
              </div>
              <div className="flex w-full items-start gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-4 shadow-sm">
                <div className="flex h-11 w-11 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M2 15c1.5-1 3.5-1 5 0s3.5 1 5 0 3.5-1 5 0 3.5 1 5 0"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M2 19c1.5-1 3.5-1 5 0s3.5 1 5 0 3.5-1 5 0 3.5 1 5 0"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 3v8"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="m8 7 4-4 4 4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-1 flex-1">
                  <div className="flex w-full items-center justify-between">
                    <span className="text-body-bold font-body-bold text-default-font">
                      Flood
                    </span>
                    <div className="flex items-center gap-1.5">
                      <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-brand-300" />
                      <span className="text-caption font-caption text-brand-600">
                        None
                      </span>
                    </div>
                  </div>
                  <span className="text-caption font-caption text-subtext-color">
                    No flood advisory in your area
                  </span>
                  <div className="flex w-full items-center gap-1 pt-1.5">
                    <div className="flex h-1.5 items-start rounded-full bg-brand-300 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                    <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                  </div>
                </div>
              </div>
            </div>
            <div className="flex w-full items-center justify-center gap-2 pt-1 pb-2">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-3.5 h-3.5"
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
                  d="M12 6v6l4 2"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
              <span className="text-caption font-caption text-neutral-400">
                Alert received Jul 25, 2026 at 10:14 AM
              </span>
            </div>
          </div>
          <div className="flex flex-col items-start gap-3 px-5 pt-4 pb-10 absolute bottom-0 left-0 right-0 bg-gradient-to-t from-neutral-0 via-neutral-0 to-transparent">
            <div className="flex w-full items-center gap-3">
              <div className="flex items-center justify-center gap-2 rounded-default bg-brand-600 px-5 py-4 shadow-lg cursor-pointer flex-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-5 h-5 flex-none"
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
                <span className="text-cta font-cta text-neutral-0">
                  View Details
                </span>
              </div>
              <div className="flex items-center justify-center rounded-default border border-solid border-neutral-200 bg-neutral-0 px-5 py-4 shadow-sm cursor-pointer flex-1">
                <span className="text-cta font-cta text-neutral-600">
                  Dismiss
                </span>
              </div>
            </div>
            <div className="flex w-full items-center justify-center">
              <span className="text-caption font-caption text-neutral-400">
                Opens Environment detail screen
              </span>
            </div>
          </div>
        </div>
      </div>
    </DialogLayout>
  );
}

export default ScrSysAlert;
