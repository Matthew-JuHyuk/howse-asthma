"use client";

import React from "react";

function ScrPatDonate() {
  return (
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
        <div className="flex w-full items-center justify-between px-5 pt-3 pb-2">
          <div className="flex items-center gap-2.5">
            <div className="flex h-10 w-10 flex-none items-center justify-center rounded-lg bg-brand-600">
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
              <span className="text-body-bold font-body-bold text-brand-700">
                Howse Asthma
              </span>
              <span className="text-caption font-caption text-neutral-400">
                SCR-PAT-DONATE
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
              Donate
            </span>
            <span className="text-body font-body text-subtext-color">
              Support asthma research
            </span>
          </div>
          <div className="flex w-full items-start gap-3 rounded-default border border-solid border-warning-200 bg-warning-50 px-4 py-3.5">
            <div className="flex h-9 w-9 flex-none items-center justify-center rounded-full bg-warning-100 mt-0.5">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-5 h-5"
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
                  d="M12 16v-4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
                <path
                  d="M12 8h.01"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
            </div>
            <div className="flex flex-col items-start gap-1.5 flex-1">
              <span className="text-body-bold font-body-bold text-warning-800">
                Transparency Notice
              </span>
              <span className="text-caption font-caption text-warning-700">
                Donations are processed via a third-party nonprofit platform.
                Howse Asthma never receives funds into its own account.
              </span>
            </div>
          </div>
          <div className="flex w-full items-center gap-3 rounded-default border border-solid border-brand-200 bg-brand-50 px-4 py-3.5">
            <div className="flex h-11 w-11 flex-none items-center justify-center rounded-full bg-brand-100">
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
            </div>
            <div className="flex flex-col items-start gap-0.5 flex-1">
              <div className="flex items-center gap-2">
                <span className="text-body-bold font-body-bold text-brand-700">
                  1,250 Points
                </span>
                <div className="flex items-center justify-center rounded-full bg-brand-600 px-2.5 py-0.5">
                  <span className="text-caption font-caption text-neutral-0">
                    $12.50 value
                  </span>
                </div>
              </div>
              <span className="text-caption font-caption text-brand-700">
                Available for donation
              </span>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-3">
            <span className="text-body-bold font-body-bold text-neutral-700">
              Select Amount
            </span>
            <div className="w-full items-start gap-3 grid grid-cols-3">
              <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3.5 cursor-pointer">
                <span className="text-body-bold font-body-bold text-neutral-700">
                  $5
                </span>
              </div>
              <div className="flex items-center justify-center self-stretch rounded-default border-2 border-solid border-brand-600 bg-brand-50 px-3 py-3.5 cursor-pointer">
                <span className="text-body-bold font-body-bold text-brand-700">
                  $10
                </span>
              </div>
              <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3.5 cursor-pointer">
                <span className="text-body-bold font-body-bold text-neutral-700">
                  $25
                </span>
              </div>
              <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3.5 cursor-pointer">
                <span className="text-body-bold font-body-bold text-neutral-700">
                  $50
                </span>
              </div>
              <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3.5 cursor-pointer">
                <span className="text-body-bold font-body-bold text-neutral-700">
                  $100
                </span>
              </div>
              <div className="flex items-center justify-center self-stretch rounded-default border border-solid border-neutral-200 bg-neutral-0 px-3 py-3.5 cursor-pointer">
                <span className="text-body font-body text-neutral-400">
                  Other
                </span>
              </div>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-3 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-4 shadow-sm">
            <div className="flex w-full items-center justify-between">
              <span className="text-body-bold font-body-bold text-default-font">
                Convert Points
              </span>
              <div className="flex items-center gap-1.5">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-500 w-4 h-4"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="m17 1 4 4-4 4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M3 11V9a4 4 0 0 1 4-4h14"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="m7 23-4-4 4-4"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M21 13v2a4 4 0 0 1-4 4H3"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-caption font-caption text-brand-600">
                  Optional
                </span>
              </div>
            </div>
            <span className="text-caption font-caption text-subtext-color">
              Use your reward points as a donation. 100 points = $1.00.
            </span>
            <div className="flex w-full items-center gap-3">
              <div className="flex items-center gap-2 rounded-default border border-solid border-brand-200 bg-brand-50 px-4 py-3 flex-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4 h-4 flex-none"
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
                <span className="text-body-bold font-body-bold text-brand-700">
                  1,000 pts
                </span>
              </div>
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-5 h-5 flex-none"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <path
                  d="m9 18 6-6-6-6"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
              <div className="flex items-center gap-2 rounded-default border border-solid border-neutral-200 bg-neutral-50 px-4 py-3 flex-1">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-500 w-4 h-4 flex-none"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M12 1a3 3 0 0 0-3 3v8a3 3 0 0 0 6 0V4a3 3 0 0 0-3-3"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M12 2v20m5-10H7"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1"
                    strokeLinecap="butt"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M9 2 L9 22"
                    fill="rgb(0 0 0)"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M15 2 L15 22"
                    fill="rgb(0 0 0)"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M6 6 L18 6"
                    fill="rgb(0 0 0)"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                  <path
                    d="M6 18 L18 18"
                    fill="rgb(0 0 0)"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="miter"
                    strokeOpacity="1"
                  />
                </svg>
                <span className="text-body-bold font-body-bold text-neutral-700">
                  $10.00
                </span>
              </div>
            </div>
            <div className="flex w-full items-center justify-center gap-2 rounded-default border border-solid border-brand-200 bg-neutral-0 px-4 py-3 cursor-pointer">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-4 h-4"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <path
                  d="m17 1 4 4-4 4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
                <path
                  d="M3 11V9a4 4 0 0 1 4-4h14"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
                <path
                  d="m7 23-4-4 4-4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
                <path
                  d="M21 13v2a4 4 0 0 1-4 4H3"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
              <span className="text-body-bold font-body-bold text-brand-600">
                Convert Points to Donation
              </span>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-3">
            <div className="flex w-full items-center justify-between">
              <span className="text-body-bold font-body-bold text-neutral-700">
                Donation History
              </span>
              <span className="text-caption font-caption text-neutral-400">
                Last 90 days
              </span>
            </div>
            <div className="flex w-full items-center gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5 shadow-sm">
              <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-success-100">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-success-600 w-5 h-5"
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
              </div>
              <div className="flex flex-col items-start gap-0.5 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    $10.00
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    Jul 15, 2026
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-caption font-caption text-subtext-color">
                    Point conversion
                  </span>
                  <span className="text-caption font-caption text-neutral-300">
                    |
                  </span>
                  <span className="text-caption font-caption text-success-600">
                    Completed
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full items-center gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5 shadow-sm">
              <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-success-100">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-success-600 w-5 h-5"
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
              </div>
              <div className="flex flex-col items-start gap-0.5 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    $25.00
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    Jun 28, 2026
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-caption font-caption text-subtext-color">
                    Direct donation
                  </span>
                  <span className="text-caption font-caption text-neutral-300">
                    |
                  </span>
                  <span className="text-caption font-caption text-success-600">
                    Completed
                  </span>
                </div>
              </div>
            </div>
            <div className="flex w-full items-center gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-3.5 shadow-sm">
              <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-success-100">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-success-600 w-5 h-5"
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
              </div>
              <div className="flex flex-col items-start gap-0.5 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    $5.00
                  </span>
                  <span className="text-caption font-caption text-neutral-400">
                    May 12, 2026
                  </span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="text-caption font-caption text-subtext-color">
                    Point conversion
                  </span>
                  <span className="text-caption font-caption text-neutral-300">
                    |
                  </span>
                  <span className="text-caption font-caption text-success-600">
                    Completed
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div className="flex w-full items-center justify-center gap-2 pt-1">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-4 h-4"
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
            <span className="text-caption font-caption text-neutral-400">
              Total donated: $40.00
            </span>
          </div>
        </div>
        <div className="flex flex-col items-center border-t border-solid border-neutral-200 bg-neutral-0 absolute bottom-[88px] left-0 right-0">
          <div className="flex w-full flex-col items-center gap-2 px-5 pt-4 pb-3">
            <div className="flex w-full items-center justify-center gap-2.5 rounded-default bg-neutral-200 px-5 py-4 cursor-not-allowed">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-5 h-5"
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
              <span className="text-cta font-cta text-neutral-400">
                Donate $10.00
              </span>
            </div>
            <div className="flex w-full items-center justify-center gap-1.5 px-2 py-1">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-400 w-3.5 h-3.5 flex-none"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <rect
                  x="3"
                  y="11"
                  width="18"
                  height="11"
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
                  d="M7 11V7a5 5 0 0 1 10 0v4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
              <span className="text-caption font-caption text-neutral-400">
                Donation provider not yet finalized
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
              <span className="text-caption font-caption text-brand-600">
                Donate
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
  );
}

export default ScrPatDonate;
