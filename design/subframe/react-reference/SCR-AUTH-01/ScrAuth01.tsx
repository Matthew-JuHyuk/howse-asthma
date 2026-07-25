"use client";

import React from "react";

function ScrAuth01() {
  return (
    <div className="flex h-full w-full flex-col items-center justify-between px-8 py-16 bg-gradient-to-b from-brand-700 via-brand-800 to-neutral-900 mobile:px-6 mobile:py-12">
      <div className="flex w-full flex-col items-center pt-8" />
      <div className="flex w-full flex-col items-center gap-8 max-w-[340px]">
        <div className="flex items-center justify-center rounded-full px-5 py-5 bg-brand-400/20">
          <svg
            className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-200 h-16 w-16"
            width="1em"
            height="1em"
            viewBox="0 0 48 48"
          >
            <path
              d="M24 6v16m0 0c-4 0-8 3-10 7s-3 10-1 13q1.5 3 6 3c2 0 3.5-1 5-3m0-20c4 0 8 3 10 7s3 10 1 13q-1.5 3-6 3c-2 0-3.5-1-5-3"
              fill="none"
              stroke="currentColor"
              strokeWidth="2.5"
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeOpacity="1"
            />
            <path
              d="M18 30c-2 1-4 1-5.5.5M30 30c2 1 4 1 5.5.5"
              fill="none"
              stroke="currentColor"
              strokeWidth="2"
              strokeLinecap="round"
              strokeLinejoin="round"
              strokeOpacity="1"
            />
          </svg>
        </div>
        <div className="flex flex-col items-center gap-3">
          <span className="text-heading-1 font-heading-1 text-neutral-0 text-center tracking-tight">
            Howse Asthma
          </span>
          <div className="flex h-0.5 w-12 flex-none items-start rounded-full bg-brand-400/50" />
        </div>
        <span className="font-['Inter'] text-[16px] font-[400] leading-[26px] text-brand-200 text-center max-w-[280px]">
          Smarter asthma prevention for every family.
        </span>
      </div>
      <div className="flex w-full flex-col items-center gap-6 pb-4 max-w-[340px]">
        <div className="flex w-full items-center justify-center rounded-default bg-brand-400 px-6 py-4 shadow-md">
          <span className="text-cta font-cta text-neutral-900 text-center">
            Get Started
          </span>
        </div>
        <span className="text-body font-body text-brand-300 text-center">
          Already have an account? Sign in
        </span>
        <div className="flex items-center gap-2 pt-2">
          <div className="flex h-2 w-2 flex-none items-start rounded-full bg-brand-400" />
          <div className="flex h-2 w-2 flex-none items-start rounded-full bg-brand-400/30" />
          <div className="flex h-2 w-2 flex-none items-start rounded-full bg-brand-400/30" />
        </div>
      </div>
    </div>
  );
}

export default ScrAuth01;
