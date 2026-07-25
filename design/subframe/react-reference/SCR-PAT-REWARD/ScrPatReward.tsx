"use client";

import React from "react";
import { DialogLayout } from "@/ui/layouts/DialogLayout";

function ScrPatReward() {
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
          <div className="flex w-full items-center justify-center gap-2 bg-warning-100 px-5 py-2">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-4 h-4 flex-none"
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
            <span className="text-caption font-caption text-warning-800">
              Draft rewards — for demo seeding only
            </span>
          </div>
          <div className="flex w-full items-center justify-between px-5 pt-3 pb-2">
            <div className="flex items-center gap-2.5">
              <div className="flex h-10 w-10 flex-none items-center justify-center rounded-lg bg-brand-600">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-5 h-5"
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
              </div>
              <div className="flex flex-col items-start">
                <span className="text-body-bold font-body-bold text-brand-700">
                  Howse Asthma
                </span>
                <span className="text-caption font-caption text-neutral-400">
                  SCR-PAT-REWARD
                </span>
              </div>
            </div>
            <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-neutral-100">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-500 w-5 h-5"
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
          <div className="flex w-full flex-col items-start gap-5 px-5 pt-3 pb-56 flex-1 overflow-y-auto">
            <div className="flex w-full flex-col items-start gap-1">
              <span className="text-heading-2 font-heading-2 text-default-font">
                Rewards
              </span>
              <span className="text-body font-body text-subtext-color">
                Earn points, redeem rewards
              </span>
            </div>
            <div className="flex w-full flex-col items-center gap-4 rounded-default border border-solid border-brand-200 bg-brand-50 px-6 py-6">
              <div className="flex flex-col items-center gap-1">
                <span className="text-caption font-caption text-brand-600">
                  Available Points
                </span>
                <span className="font-['Inter'] text-[56px] font-[700] leading-[64px] tracking-tight text-brand-700">
                  320
                </span>
              </div>
              <div className="flex h-0.5 w-16 flex-none items-start rounded-full bg-brand-200" />
              <div className="flex items-center gap-4">
                <div className="flex items-center gap-1.5">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-500 w-4 h-4 flex-none"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="m5 12 5 5L20 7"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2.5"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                  </svg>
                  <span className="text-caption font-caption text-brand-700">
                    180 earned
                  </span>
                </div>
                <span className="text-caption font-caption text-brand-300">
                  |
                </span>
                <div className="flex items-center gap-1.5">
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
                    140 bonus
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full flex-col items-start gap-3">
              <span className="text-body-bold font-body-bold text-neutral-700">
                How You Earn
              </span>
              <div className="flex w-full items-center gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5 shadow-sm">
                <div className="flex h-11 w-11 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
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
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 20v2"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                    <path
                      d="M10 22h4"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="1.8"
                      strokeLinecap="round"
                      strokeLinejoin="miter"
                      strokeOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Daily Inhaler Log
                  </span>
                  <span className="text-caption font-caption text-subtext-color">
                    Log each use to earn points
                  </span>
                </div>
                <div className="flex items-center justify-center rounded-full bg-brand-100 px-2.5 py-1">
                  <span className="text-caption font-caption text-brand-700">
                    +5 pts
                  </span>
                </div>
              </div>
              <div className="flex w-full items-center gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5 shadow-sm">
                <div className="flex h-11 w-11 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
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
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Asthma Check (ACT)
                  </span>
                  <span className="text-caption font-caption text-subtext-color">
                    Complete monthly assessment
                  </span>
                </div>
                <div className="flex items-center justify-center rounded-full bg-brand-100 px-2.5 py-1">
                  <span className="text-caption font-caption text-brand-700">
                    +10 pts
                  </span>
                </div>
              </div>
              <div className="flex w-full items-center gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5 shadow-sm">
                <div className="flex h-11 w-11 flex-none items-center justify-center rounded-lg bg-brand-50">
                  <svg
                    className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
                    width="1em"
                    height="1em"
                    viewBox="0 0 24 24"
                  >
                    <path
                      d="M12 2c-1 4-4 6-4 10a4 4 0 0 0 8 0c0-4-3-6-4-10"
                      fill="none"
                      stroke="currentColor"
                      strokeWidth="2"
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeOpacity="1"
                    />
                    <path
                      d="M12 18a2 2 0 0 1-2-2c0-2 2-3 2-5 0 2 2 3 2 5a2 2 0 0 1-2 2"
                      fill="currentColor"
                      fillOpacity="1"
                    />
                  </svg>
                </div>
                <div className="flex flex-col items-start gap-0.5 flex-1">
                  <span className="text-body-bold font-body-bold text-default-font">
                    7-Day Streak
                  </span>
                  <span className="text-caption font-caption text-subtext-color">
                    Log every day for a week
                  </span>
                </div>
                <div className="flex items-center justify-center rounded-full bg-brand-100 px-2.5 py-1">
                  <span className="text-caption font-caption text-brand-700">
                    +25 pts
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full flex-col items-start gap-3">
              <div className="flex w-full items-center justify-between">
                <span className="text-body-bold font-body-bold text-neutral-700">
                  Recent Earnings
                </span>
                <span className="text-caption font-caption text-neutral-400">
                  This month
                </span>
              </div>
              <div className="flex w-full flex-col items-start rounded-default border border-solid border-neutral-200 bg-neutral-0 shadow-sm">
                <div className="flex w-full items-center gap-3 border-b border-solid border-neutral-100 px-4 py-3">
                  <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-brand-100">
                    <svg
                      className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4 h-4"
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
                        strokeWidth="1.8"
                        strokeLinecap="round"
                        strokeLinejoin="miter"
                        strokeOpacity="1"
                      />
                      <path
                        d="M12 20v2"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="1.8"
                        strokeLinecap="round"
                        strokeLinejoin="miter"
                        strokeOpacity="1"
                      />
                      <path
                        d="M10 22h4"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="1.8"
                        strokeLinecap="round"
                        strokeLinejoin="miter"
                        strokeOpacity="1"
                      />
                    </svg>
                  </div>
                  <div className="flex flex-col items-start flex-1">
                    <span className="text-caption font-caption text-default-font">
                      Inhaler logged
                    </span>
                    <span className="text-caption font-caption text-neutral-400">
                      Today, 8:15 AM
                    </span>
                  </div>
                  <span className="text-body-bold font-body-bold text-brand-600">
                    +5
                  </span>
                </div>
                <div className="flex w-full items-center gap-3 border-b border-solid border-neutral-100 px-4 py-3">
                  <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-brand-100">
                    <svg
                      className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4 h-4"
                      width="1em"
                      height="1em"
                      viewBox="0 0 24 24"
                    >
                      <path
                        d="M12 2c-1 4-4 6-4 10a4 4 0 0 0 8 0c0-4-3-6-4-10"
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
                    <span className="text-caption font-caption text-default-font">
                      7-day streak bonus
                    </span>
                    <span className="text-caption font-caption text-neutral-400">
                      Jul 24
                    </span>
                  </div>
                  <span className="text-body-bold font-body-bold text-brand-600">
                    +25
                  </span>
                </div>
                <div className="flex w-full items-center gap-3 border-b border-solid border-neutral-100 px-4 py-3">
                  <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-brand-100">
                    <svg
                      className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4 h-4"
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
                    </svg>
                  </div>
                  <div className="flex flex-col items-start flex-1">
                    <span className="text-caption font-caption text-default-font">
                      ACT check completed
                    </span>
                    <span className="text-caption font-caption text-neutral-400">
                      Jul 20
                    </span>
                  </div>
                  <span className="text-body-bold font-body-bold text-brand-600">
                    +10
                  </span>
                </div>
                <div className="flex w-full items-center gap-3 px-4 py-3">
                  <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-brand-100">
                    <svg
                      className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4 h-4"
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
                        strokeWidth="1.8"
                        strokeLinecap="round"
                        strokeLinejoin="miter"
                        strokeOpacity="1"
                      />
                      <path
                        d="M12 20v2"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="1.8"
                        strokeLinecap="round"
                        strokeLinejoin="miter"
                        strokeOpacity="1"
                      />
                      <path
                        d="M10 22h4"
                        fill="none"
                        stroke="currentColor"
                        strokeWidth="1.8"
                        strokeLinecap="round"
                        strokeLinejoin="miter"
                        strokeOpacity="1"
                      />
                    </svg>
                  </div>
                  <div className="flex flex-col items-start flex-1">
                    <span className="text-caption font-caption text-default-font">
                      Inhaler logged
                    </span>
                    <span className="text-caption font-caption text-neutral-400">
                      Jul 19
                    </span>
                  </div>
                  <span className="text-body-bold font-body-bold text-brand-600">
                    +5
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full items-start gap-2.5 rounded-md bg-warning-50 px-3.5 py-3">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-4 h-4 mt-0.5 flex-none"
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
              <span className="text-caption font-caption text-warning-800">
                Point values and conversion rates are subject to change. Final
                policy will be set before public launch.
              </span>
            </div>
          </div>
          <div className="flex flex-col items-start gap-3 px-5 pt-4 pb-28 absolute bottom-0 left-0 right-0 bg-gradient-to-t from-neutral-0 via-neutral-0 to-transparent">
            <div className="flex w-full items-center gap-3">
              <div className="flex flex-col items-center gap-1.5 rounded-default bg-brand-600 px-5 py-4 shadow-md cursor-pointer flex-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <rect
                    x="3"
                    y="6"
                    width="18"
                    height="13"
                    rx="2"
                    ry="2"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M3 10h18"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M7 15h4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-cta font-cta text-neutral-0">
                  Exchange
                </span>
                <span className="text-caption font-caption text-brand-200">
                  50-pt voucher
                </span>
              </div>
              <div className="flex flex-col items-center gap-1.5 rounded-default border-2 border-solid border-brand-600 bg-neutral-0 px-5 py-4 shadow-md cursor-pointer flex-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-cta font-cta text-brand-700">Donate</span>
                <span className="text-caption font-caption text-brand-600">
                  Give your points
                </span>
              </div>
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
                    d="m3 12 2-2m0 0 7-7 7 7M5 10v10a1 1 0 0 0 1 1h3m10-11 2 2m-2-2v10a1 1 0 0 1-1 1h-3m-6 0a1 1 0 0 0 1-1v-4a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v4a1 1 0 0 0 1 1m-6 0h6"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
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
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
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
                <span className="text-caption font-caption text-brand-600">
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

export default ScrPatReward;
