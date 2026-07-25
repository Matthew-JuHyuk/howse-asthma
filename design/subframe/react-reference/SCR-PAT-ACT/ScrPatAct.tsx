"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrPatAct() {
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
                Asthma Check
              </span>
              <span className="text-caption font-caption text-neutral-400">
                SCR-PAT-ACT
              </span>
            </div>
            <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-brand-50 cursor-pointer">
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
                  d="M12 16v-4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
                <ellipse
                  cx="12"
                  cy="8"
                  rx="0.5"
                  ry="0.5"
                  fill="currentColor"
                  fillOpacity="1"
                />
              </svg>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-6 px-5 pt-2 pb-48 flex-1 overflow-y-auto">
            <div className="flex w-full flex-col items-start gap-3">
              <div className="flex w-full items-center gap-2">
                <div className="flex h-1.5 items-start rounded-full bg-brand-500 flex-1" />
                <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
              </div>
              <div className="flex w-full items-center justify-between">
                <span className="text-caption font-caption text-brand-600">
                  Question 1 of 5
                </span>
                <div className="flex items-center gap-1.5 rounded-full bg-brand-50 px-3 py-1">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-500 w-3.5 h-3.5"
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
                  <span className="text-caption font-caption text-brand-600">
                    ~3 min
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full flex-col items-center gap-4 pt-2">
              <div className="flex h-20 w-20 flex-none items-center justify-center rounded-full bg-brand-50">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-10 h-10"
                  width="1em"
                  height="1em"
                  viewBox="0 0 48 48"
                >
                  <path
                    d="M14 38V22l-4 4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="3"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="m14 22 4 4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="3"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <ellipse
                    cx="24"
                    cy="12"
                    rx="5"
                    ry="5"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="3"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M18 22c0-3.3 2.7-6 6-6s6 2.7 6 6"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="3"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M34 38V22l4 4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="3"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="m34 22-4 4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="3"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <rect
                    x="19"
                    y="28"
                    width="10"
                    height="10"
                    rx="2"
                    ry="2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M22 32h4m-4 3h2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
              </div>
              <span className="text-heading-2 font-heading-2 text-default-font text-center">
                How much did asthma limit your activities?
              </span>
              <span className="text-body font-body text-subtext-color text-center">
                In the past 4 weeks
              </span>
            </div>
            <div className="flex w-full flex-col items-start gap-3 pt-2">
              <div className="flex w-full items-center gap-4 rounded-default border-2 border-solid border-brand-600 bg-brand-50 px-5 py-4 shadow-sm cursor-pointer">
                <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-brand-100">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-700 w-7 h-7"
                    width="1em"
                    height="1em"
                    viewBox="0 0 28 28"
                  >
                    <ellipse
                      cx="14"
                      cy="14"
                      rx="12"
                      ry="12"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <ellipse
                      cx="10"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <ellipse
                      cx="18"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <path
                      d="M10 20c1.2-2 2.5-3 4-3s2.8 1 4 3"
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
                  <span className="text-body-bold font-body-bold text-brand-700">
                    All the time
                  </span>
                  <span className="text-caption font-caption text-brand-600">
                    1 point
                  </span>
                </div>
                <div className="flex h-6 w-6 flex-none items-center justify-center rounded-full bg-brand-600">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-3.5 h-3.5"
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
              <div className="flex w-full items-center gap-4 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-5 py-4 shadow-sm cursor-pointer">
                <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-warning-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-7 h-7"
                    width="1em"
                    height="1em"
                    viewBox="0 0 28 28"
                  >
                    <ellipse
                      cx="14"
                      cy="14"
                      rx="12"
                      ry="12"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <ellipse
                      cx="10"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <ellipse
                      cx="18"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <path
                      d="M11 19q1.2-1.8 3-1.8c1.8 0 2.2.6 3 1.8"
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
                    Most of the time
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    2 points
                  </span>
                </div>
                <div className="flex h-6 w-6 flex-none items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0" />
              </div>
              <div className="flex w-full items-center gap-4 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-5 py-4 shadow-sm cursor-pointer">
                <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-neutral-100">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-500 w-7 h-7"
                    width="1em"
                    height="1em"
                    viewBox="0 0 28 28"
                  >
                    <ellipse
                      cx="14"
                      cy="14"
                      rx="12"
                      ry="12"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <ellipse
                      cx="10"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <ellipse
                      cx="18"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <path
                      d="M10 18h8"
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
                    Some of the time
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    3 points
                  </span>
                </div>
                <div className="flex h-6 w-6 flex-none items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0" />
              </div>
              <div className="flex w-full items-center gap-4 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-5 py-4 shadow-sm cursor-pointer">
                <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-success-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-success-600 w-7 h-7"
                    width="1em"
                    height="1em"
                    viewBox="0 0 28 28"
                  >
                    <ellipse
                      cx="14"
                      cy="14"
                      rx="12"
                      ry="12"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <ellipse
                      cx="10"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <ellipse
                      cx="18"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <path
                      d="M11 17.5q1.2 1.5 3 1.5c1.8 0 2.2-.5 3-1.5"
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
                    A little of the time
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    4 points
                  </span>
                </div>
                <div className="flex h-6 w-6 flex-none items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0" />
              </div>
              <div className="flex w-full items-center gap-4 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-5 py-4 shadow-sm cursor-pointer">
                <div className="flex h-12 w-12 flex-none items-center justify-center rounded-full bg-success-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-success-600 w-7 h-7"
                    width="1em"
                    height="1em"
                    viewBox="0 0 28 28"
                  >
                    <ellipse
                      cx="14"
                      cy="14"
                      rx="12"
                      ry="12"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <ellipse
                      cx="10"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <ellipse
                      cx="18"
                      cy="11"
                      rx="1.2"
                      ry="1.5"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                    <path
                      d="M10 17c1.2 1.8 2.5 2.5 4 2.5s2.8-.7 4-2.5"
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
                    Not at all
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    5 points
                  </span>
                </div>
                <div className="flex h-6 w-6 flex-none items-center justify-center rounded-full border border-solid border-neutral-300 bg-neutral-0" />
              </div>
            </div>
            <div className="flex w-full items-center justify-center pt-1">
              <div className="flex items-center gap-2 rounded-full bg-brand-50 px-4 py-2">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-500 w-4 h-4 flex-none"
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
                <span className="text-caption font-caption text-brand-700">
                  +10 points for completing this check
                </span>
              </div>
            </div>
          </div>
          <div className="flex flex-col items-start gap-3 px-5 pt-4 pb-10 absolute bottom-0 left-0 right-0 bg-gradient-to-t from-neutral-0 via-neutral-0 to-transparent">
            <div className="flex h-14 w-full flex-none items-center justify-center gap-2 rounded-lg bg-brand-600 shadow-md cursor-pointer">
              <span className="text-cta font-cta text-neutral-0">Next</span>
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-5 h-5"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <path
                  d="m9 18 6-6-6-6"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2.5"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
            </div>
            <div className="flex w-full items-center justify-center">
              <span className="text-caption font-caption text-neutral-400">
                You can change answers before submitting
              </span>
            </div>
          </div>
        </div>
      </div>
    </DialogLayout>
  );
}

export default ScrPatAct;
