"use client";

import React from "react";

function ScrPatHome() {
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
                fill="rgb(0 0 0)"
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
                fill="rgb(0 0 0)"
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
                fill="rgb(0 0 0)"
              />
              <path d="M20 5v2a1.5 1.5 0 0 0 0-2" fill="rgb(0 0 0)" />
            </svg>
          </div>
        </div>
        <div className="flex w-full flex-col items-start gap-5 px-5 pt-3 pb-56 flex-1 overflow-y-auto">
          <div className="flex w-full items-center justify-between">
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
                    stroke="rgb(0 0 0)"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M12 3c-3 3-5 6-5 9a5 5 0 0 0 3 4.5c-1.5.5-3 1.5-3.5 3s.5 3 2 3 2.5-1 3.5-3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M12 3c3 3 5 6 5 9a5 5 0 0 1-3 4.5c1.5.5 3 1.5 3.5 3s-.5 3-2 3-2.5-1-3.5-3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                </svg>
              </div>
              <div className="flex flex-col items-start">
                <span className="text-body-bold font-body-bold text-brand-700">
                  Howse Asthma
                </span>
                <span className="text-caption font-caption text-neutral-400">
                  SCR-PAT-HOME
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
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M13.73 21a2 2 0 0 1-3.46 0"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-1">
            <span className="text-heading-2 font-heading-2 text-default-font">
              Good morning
            </span>
            <span className="text-body font-body text-subtext-color">
              Here is your daily summary
            </span>
          </div>
          <div className="flex w-full items-center gap-3 rounded-default border border-solid border-brand-200 bg-brand-50 px-4 py-3.5">
            <div className="flex h-11 w-11 flex-none items-center justify-center rounded-full bg-brand-100">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <path
                  d="M22 12h-4l-3 9L9 3l-3 9H2"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
              </svg>
            </div>
            <div className="flex flex-col items-start gap-0.5 flex-1">
              <div className="flex items-center gap-2">
                <span className="text-body-bold font-body-bold text-brand-700">
                  CALM
                </span>
                <div className="flex items-center justify-center rounded-full bg-brand-600 px-2.5 py-0.5">
                  <span className="text-caption font-caption text-neutral-0">
                    Score 1
                  </span>
                </div>
              </div>
              <span className="text-caption font-caption text-brand-700">
                Risk level is low today
              </span>
            </div>
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-400 w-5 h-5"
              width="1em"
              height="1em"
              viewBox="0 0 24 24"
            >
              <path
                d="m9 18 6-6-6-6"
                fill="none"
                stroke="rgb(0 0 0)"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
          </div>
          <div className="flex w-full flex-col items-start gap-3">
            <span className="text-body-bold font-body-bold text-neutral-700">
              Environmental Factors
            </span>
            <div className="flex w-full items-start gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-4 shadow-sm">
              <div className="flex h-11 w-11 flex-none items-center justify-center rounded-lg bg-neutral-100">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-600 w-6 h-6"
                  width="1em"
                  height="1em"
                  viewBox="0 0 24 24"
                >
                  <path
                    d="M3 21h18"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M5 21V7l3-4h8l3 4v14"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M9 21v-6h6v6"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M2 11h20"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M7 11v3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M12 11v3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M17 11v3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
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
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M2 19c1.5-1 3.5-1 5 0s3.5 1 5 0 3.5-1 5 0 3.5 1 5 0"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M12 3v8"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="m8 7 4-4 4 4"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                </svg>
              </div>
              <div className="flex flex-col items-start gap-1 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Flood
                  </span>
                  <div className="flex items-center gap-1.5">
                    <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-brand-400" />
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
            <div className="flex w-full items-start gap-3.5 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-4 py-4 shadow-sm">
              <div className="flex h-11 w-11 flex-none items-center justify-center rounded-lg bg-warning-50">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-6 h-6"
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
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M12 3v3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M12 18v3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M3 12h3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="M18 12h3"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="m5.6 5.6 2.1 2.1"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="m16.3 16.3 2.1 2.1"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="m5.6 18.4 2.1-2.1"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                  <path
                    d="m16.3 7.7 2.1-2.1"
                    fill="none"
                    stroke="rgb(0 0 0)"
                    strokeWidth="1.8"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                  />
                </svg>
              </div>
              <div className="flex flex-col items-start gap-1 flex-1">
                <div className="flex w-full items-center justify-between">
                  <span className="text-body-bold font-body-bold text-default-font">
                    Pollen
                  </span>
                  <div className="flex items-center gap-1.5">
                    <div className="flex h-2.5 w-2.5 flex-none items-start rounded-full bg-warning-400" />
                    <span className="text-caption font-caption text-warning-600">
                      Moderate
                    </span>
                  </div>
                </div>
                <span className="text-caption font-caption text-subtext-color">
                  Tree pollen is elevated today
                </span>
                <div className="flex w-full items-center gap-1 pt-1.5">
                  <div className="flex h-1.5 items-start rounded-full bg-warning-400 flex-1" />
                  <div className="flex h-1.5 items-start rounded-full bg-warning-400 flex-1" />
                  <div className="flex h-1.5 items-start rounded-full bg-warning-300 flex-1" />
                  <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
                  <div className="flex h-1.5 items-start rounded-full bg-neutral-200 flex-1" />
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
              <ellipse
                cx="12"
                cy="12"
                rx="10"
                ry="10"
                fill="none"
                stroke="rgb(0 0 0)"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
              <path
                d="M12 6v6l4 2"
                fill="none"
                stroke="rgb(0 0 0)"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              />
            </svg>
            <span className="text-caption font-caption text-neutral-400">
              Last inhaler use: 2 days ago
            </span>
          </div>
        </div>
        <div className="flex items-center justify-center absolute bottom-28 left-0 right-0 pointer-events-none">
          <div className="flex h-24 w-24 flex-none items-center justify-center rounded-full bg-brand-600 shadow-lg cursor-pointer pointer-events-auto">
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
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-6 h-6"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <path d="M12 3 2 12h3v8h5v-6h4v6h5v-8h3z" fill="rgb(0 0 0)" />
              </svg>
              <span className="text-caption font-caption text-brand-600">
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
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M14 2v6h6"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M16 13H8"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M16 17H8"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M10 9H8"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
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
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M12 20V4"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M6 20v-6"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
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
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M15.477 12.89 17 22l-5-3-5 3 1.523-9.11"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
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
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                />
                <path
                  d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.9 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06a1.65 1.65 0 0 0 1.9.33 1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1"
                  fill="none"
                  stroke="rgb(0 0 0)"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
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

export default ScrPatHome;
