"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrPatHome_Warn() {
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
          <div className="flex w-full items-center justify-center gap-2.5 bg-error-500 px-5 py-3">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-5 h-5 flex-none"
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
            <span className="text-cta font-cta text-neutral-0">
              WARNING — Score 3
            </span>
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-5 h-5 flex-none"
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
          <div className="flex w-full flex-col items-start gap-5 px-5 pt-4 pb-56 flex-1 overflow-y-auto">
            <div className="flex w-full items-center justify-between">
              <div className="flex items-center gap-2.5">
                <div className="flex h-10 w-10 flex-none items-center justify-center rounded-lg bg-error-500">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-5 h-5"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M12 3v10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 3c-3 3-5 6-5 9a5 5 0 0 0 3 4.5c-1.5.5-3 1.5-3.5 3s.5 3 2 3 2.5-1 3.5-3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 3c3 3 5 6 5 9a5 5 0 0 1-3 4.5c1.5.5 3 1.5 3.5 3s-.5 3-2 3-2.5-1-3.5-3"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start">
                  <span className="text-body-bold font-body-bold text-error-600">
                    Howse Asthma
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    SCR-PAT-HOME
                  </span>
                </div>
              </div>
              <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-error-50">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-500 w-5 h-5"
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
            </div>
            <div className="flex w-full flex-col items-start gap-1">
              <span className="text-heading-1 font-heading-1 text-default-font">
                Attention needed
              </span>
              <span className="text-body-bold font-body-bold text-error-600">
                Your risk level is elevated today
              </span>
            </div>
            <div className="flex w-full items-center gap-3 rounded-default border-2 border-solid border-error-300 bg-error-50 px-4 py-4">
              <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-error-500">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M22 12h-4l-3 9L9 3l-3 9H2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
              </div>
              <div className="flex flex-col items-start gap-1 flex-1">
                <div className="flex items-center gap-2">
                  <span className="text-cta font-cta text-error-700">
                    WARNING
                  </span>
                  <div className="flex items-center justify-center rounded-full bg-error-500 px-3 py-0.5">
                    <span className="text-caption font-caption text-neutral-0">
                      Score 3
                    </span>
                  </div>
                </div>
                <span className="text-body font-body text-error-600">
                  Multiple risk factors elevated
                </span>
              </div>
            </div>
            <div className="flex w-full items-center gap-3">
              <div className="flex items-center justify-center gap-2.5 rounded-default bg-error-500 px-5 py-4 shadow-lg cursor-pointer flex-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-6 h-6 flex-none"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <rect
                    x="8"
                    y="2"
                    width="8"
                    height="16"
                    rx="4"
                    ry="4"
                    fill="currentColor"
                    fillOpacity="1"
                  />
                  <path
                    d="M7 13c0 2.8 2.2 5 5 5s5-2.2 5-5"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M12 20v2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M10 22h4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-cta font-cta text-neutral-0">
                  Log Inhaler
                </span>
              </div>
              <div className="flex items-center justify-center gap-2.5 rounded-default border-2 border-solid border-error-400 bg-neutral-0 px-5 py-4 shadow-md cursor-pointer flex-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-600 w-6 h-6 flex-none"
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
                <span className="text-cta font-cta text-error-600">
                  What to Do
                </span>
              </div>
            </div>
            <div className="flex w-full items-center gap-2">
              <span className="text-cta font-cta text-error-700">
                Environmental Factors
              </span>
              <div className="flex h-px items-start bg-error-200 flex-1" />
            </div>
            <div className="flex w-full items-start gap-3.5 rounded-default border-2 border-solid border-error-200 bg-neutral-0 px-4 py-4 shadow-sm">
              <div className="flex h-12 w-12 flex-none items-center justify-center rounded-lg bg-error-50">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-600 w-6 h-6"
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
              <div className="flex flex-col items-start gap-1.5 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    TRAP
                  </span>
                  <div className="flex items-center gap-1.5 rounded-full bg-error-50 px-2.5 py-1">
                    <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-error-500" />
                    <span className="text-caption font-caption text-error-700">
                      High
                    </span>
                  </div>
                </div>
                <span className="text-caption font-caption text-subtext-color">
                  Air-quality proxy — not truck counts
                </span>
                <div className="flex w-full items-center gap-1 pt-1">
                  <div className="flex h-2 items-start rounded-full bg-error-400 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-error-400 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-error-300 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-error-200 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-neutral-200 flex-1" />
                </div>
                <div className="flex w-full items-start gap-2.5 rounded-md bg-error-50 px-3 py-2.5 mt-1">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-500 w-4 h-4 mt-0.5 flex-none"
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
                    <path
                      d="M12 17h.01"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-error-800 flex-1">
                    Roadside PM elevated — limit outdoor activity
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full items-start gap-3.5 rounded-default border-2 border-solid border-warning-200 bg-neutral-0 px-4 py-4 shadow-sm">
              <div className="flex h-12 w-12 flex-none items-center justify-center rounded-lg bg-warning-50">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-6 h-6"
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
              <div className="flex flex-col items-start gap-1.5 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Flood
                  </span>
                  <div className="flex items-center gap-1.5 rounded-full bg-warning-50 px-2.5 py-1">
                    <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-warning-400" />
                    <span className="text-caption font-caption text-warning-700">
                      Moderate
                    </span>
                  </div>
                </div>
                <span className="text-caption font-caption text-subtext-color">
                  Flash-flood advisory in your area
                </span>
                <div className="flex w-full items-center gap-1 pt-1">
                  <div className="flex h-2 items-start rounded-full bg-warning-400 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-warning-400 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-warning-300 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-neutral-200 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-neutral-200 flex-1" />
                </div>
                <div className="flex w-full items-start gap-2.5 rounded-md bg-warning-50 px-3 py-2.5 mt-1">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-4 h-4 mt-0.5 flex-none"
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
                    <path
                      d="M12 17h.01"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-warning-800 flex-1">
                    Avoid low-lying roads and stay indoors
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full items-start gap-3.5 rounded-default border-2 border-solid border-error-200 bg-neutral-0 px-4 py-4 shadow-sm">
              <div className="flex h-12 w-12 flex-none items-center justify-center rounded-lg bg-error-50">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-600 w-6 h-6"
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
              <div className="flex flex-col items-start gap-1.5 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Pollen
                  </span>
                  <div className="flex items-center gap-1.5 rounded-full bg-error-50 px-2.5 py-1">
                    <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-error-500" />
                    <span className="text-caption font-caption text-error-700">
                      High
                    </span>
                  </div>
                </div>
                <span className="text-caption font-caption text-subtext-color">
                  Tree and grass pollen very high today
                </span>
                <div className="flex w-full items-center gap-1 pt-1">
                  <div className="flex h-2 items-start rounded-full bg-error-400 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-error-400 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-error-400 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-error-300 flex-1" />
                  <div className="flex h-2 items-start rounded-full bg-neutral-200 flex-1" />
                </div>
                <div className="flex w-full items-start gap-2.5 rounded-md bg-error-50 px-3 py-2.5 mt-1">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-500 w-4 h-4 mt-0.5 flex-none"
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
                    <path
                      d="M12 17h.01"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-error-800 flex-1">
                    Close windows and keep rescue inhaler nearby
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full items-center justify-center gap-2 pt-1">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-400 w-4 h-4 flex-none"
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
              <span className="text-caption font-caption text-error-400">
                Last inhaler use: 6 hours ago
              </span>
            </div>
          </div>
          <div className="flex items-center justify-center absolute bottom-28 left-0 right-0 pointer-events-none">
            <div className="flex h-24 w-24 flex-none items-center justify-center rounded-full bg-error-500 shadow-lg cursor-pointer pointer-events-auto">
              <div className="flex flex-col items-center gap-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-9 h-9"
                  width="1em"
                  height="1em"
                  viewBox="0 0 36 36"
                >
                  <rect
                    x="14"
                    y="2"
                    width="8"
                    height="20"
                    rx="4"
                    ry="4"
                    fill="currentColor"
                    fillOpacity="1"
                  />
                  <path
                    d="M11 16c0 3.9 3.1 7 7 7s7-3.1 7-7"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M18 25v5"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M14 30h8"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-neutral-0">
                  1-Tap
                </span>
              </div>
            </div>
          </div>
          <div className="flex flex-col items-center border-t border-solid border-neutral-200 bg-neutral-0 absolute bottom-0 left-0 right-0">
            <div className="flex w-full px-2 pt-2.5 pb-7 items-end justify-around">
              <div className="flex flex-col items-center gap-1 px-3 py-1 cursor-pointer">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-error-500 w-6 h-6"
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
                <span className="text-caption font-caption text-error-500">
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
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-6 h-6"
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
                <span className="text-caption font-caption text-neutral-400">
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

export default ScrPatHome_Warn;
