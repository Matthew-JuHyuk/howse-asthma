"use client";

import React from "react";

function ScrPatVoucher() {
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
                SCR-PAT-VOUCHER
              </span>
            </div>
          </div>
          <div className="flex h-10 w-10 flex-none items-center justify-center rounded-full bg-neutral-100 cursor-pointer">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-500 w-5 h-5"
              width="1em"
              height="1em"
              viewBox="0 0 24 24"
            >
              <path
                d="M18 6 6 18"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeOpacity="1"
              />
              <path
                d="m6 6 12 12"
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
        <div className="flex w-full flex-col items-start gap-5 px-5 pt-4 pb-56 flex-1 overflow-y-auto">
          <div className="flex w-full flex-col items-start gap-1">
            <span className="text-heading-2 font-heading-2 text-default-font">
              Redeem Voucher
            </span>
            <span className="text-body font-body text-subtext-color">
              Exchange points for rewards
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
              <span className="text-body-bold font-body-bold text-brand-700">
                Your Balance
              </span>
              <span className="text-caption font-caption text-brand-600">
                120 points available
              </span>
            </div>
            <div className="flex items-center justify-center rounded-full bg-brand-600 px-3 py-1">
              <span className="text-caption font-caption text-neutral-0">
                120 pts
              </span>
            </div>
          </div>
          <div className="flex w-full items-center gap-3 rounded-default border border-solid border-warning-200 bg-warning-50 px-4 py-3">
            <svg
              className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-5 h-5 flex-none"
              width="1em"
              height="1em"
              viewBox="0 0 24 24"
            >
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
              <path
                d="M10.29 3.86 1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeOpacity="1"
              />
            </svg>
            <div className="flex flex-col items-start gap-0.5 flex-1">
              <span className="text-caption font-caption text-warning-700">
                Draft rewards — partners not finalized
              </span>
              <span className="text-caption font-caption text-warning-600">
                Items shown are placeholders for UX-Q4
              </span>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-4 rounded-default border border-solid border-neutral-200 bg-neutral-0 px-5 py-5 shadow-sm">
            <div className="flex w-full items-center gap-2">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-5 h-5 flex-none"
                width="1em"
                height="1em"
                viewBox="0 0 24 24"
              >
                <path
                  d="M20 12V8H6a2 2 0 0 1 0-4h12V2H6a4 4 0 0 0-4 4v12a4 4 0 0 0 4 4h14v-6"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
                <path
                  d="m20 12-4-4m4 4-4 4"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
              <span className="text-body-bold font-body-bold text-default-font">
                Exchange Item
              </span>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-100" />
            <div className="flex w-full items-start gap-4">
              <div className="flex h-20 w-20 flex-none items-center justify-center rounded-lg bg-brand-50">
                <svg
                  className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-brand-600 w-10 h-10"
                  width="1em"
                  height="1em"
                  viewBox="0 0 40 40"
                >
                  <path
                    d="M6 10h28v4a4 4 0 0 1-4 4H10a4 4 0 0 1-4-4z"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M8 18v14h24V18"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="2"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M16 18v14"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M24 18v14"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="M8 24h24"
                    fill="none"
                    stroke="currentColor"
                    strokeWidth="1.5"
                    strokeLinecap="round"
                    strokeLinejoin="round"
                    strokeOpacity="1"
                  />
                  <path
                    d="m12 6 8 4 8-4"
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
                <span className="text-body-bold font-body-bold text-default-font">
                  Food Bank Voucher
                </span>
                <span className="text-caption font-caption text-subtext-color">
                  Redeemable at participating food banks near you
                </span>
                <div className="flex items-center gap-2 pt-1">
                  <div className="flex items-center justify-center rounded-full bg-brand-100 px-3 py-1">
                    <span className="text-caption font-caption text-brand-700">
                      50 pts
                    </span>
                  </div>
                  <span className="text-caption font-caption text-neutral-400">
                    $10 value
                  </span>
                </div>
              </div>
            </div>
            <div className="flex h-px w-full flex-none items-start bg-neutral-100" />
            <div className="flex w-full flex-col items-start gap-2.5">
              <div className="flex w-full items-center justify-between">
                <span className="text-body font-body text-neutral-500">
                  Item cost
                </span>
                <span className="text-body font-body text-default-font">
                  50 pts
                </span>
              </div>
              <div className="flex w-full items-center justify-between">
                <span className="text-body font-body text-neutral-500">
                  Your balance
                </span>
                <span className="text-body font-body text-default-font">
                  120 pts
                </span>
              </div>
              <div className="flex h-px w-full flex-none items-start bg-neutral-200" />
              <div className="flex w-full items-center justify-between">
                <span className="text-body-bold font-body-bold text-default-font">
                  Remaining after
                </span>
                <span className="text-body-bold font-body-bold text-brand-700">
                  70 pts
                </span>
              </div>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-3 rounded-default border border-solid border-warning-200 bg-warning-50 px-5 py-4">
            <div className="flex w-full items-center gap-2.5">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-5 h-5 flex-none"
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
              <span className="text-body-bold font-body-bold text-warning-700">
                Important Notice
              </span>
            </div>
            <span className="text-caption font-caption text-warning-700">
              This reward partner has not been finalized. By confirming, you
              will be added to a waitlist. No voucher will be issued at this
              time.
            </span>
            <div className="flex w-full items-center gap-2 rounded-md bg-warning-100 px-3 py-2">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-warning-600 w-4 h-4 flex-none"
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
              <span className="text-caption font-caption text-warning-800">
                Points are held until a partner is confirmed
              </span>
            </div>
          </div>
          <div className="flex w-full flex-col items-start gap-3">
            <span className="text-body-bold font-body-bold text-neutral-700">
              How it works
            </span>
            <div className="flex w-full items-start gap-3">
              <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-brand-100">
                <span className="text-caption font-caption text-brand-700">
                  1
                </span>
              </div>
              <div className="flex flex-col items-start gap-0.5 pt-1 flex-1">
                <span className="text-caption font-caption text-default-font">
                  Confirm to join the waitlist
                </span>
                <span className="text-caption font-caption text-neutral-400">
                  50 points will be held from your balance
                </span>
              </div>
            </div>
            <div className="flex w-full items-start gap-3">
              <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-brand-100">
                <span className="text-caption font-caption text-brand-700">
                  2
                </span>
              </div>
              <div className="flex flex-col items-start gap-0.5 pt-1 flex-1">
                <span className="text-caption font-caption text-default-font">
                  Partner finalized
                </span>
                <span className="text-caption font-caption text-neutral-400">
                  You will be notified when the partner is confirmed
                </span>
              </div>
            </div>
            <div className="flex w-full items-start gap-3">
              <div className="flex h-8 w-8 flex-none items-center justify-center rounded-full bg-brand-100">
                <span className="text-caption font-caption text-brand-700">
                  3
                </span>
              </div>
              <div className="flex flex-col items-start gap-0.5 pt-1 flex-1">
                <span className="text-caption font-caption text-default-font">
                  Voucher issued
                </span>
                <span className="text-caption font-caption text-neutral-400">
                  Receive your voucher code in the app
                </span>
              </div>
            </div>
          </div>
        </div>
        <div className="flex flex-col items-center border-t border-solid border-neutral-200 bg-neutral-0 absolute bottom-0 left-0 right-0">
          <div className="flex w-full flex-col items-center gap-3 px-5 pt-4 pb-8">
            <div className="flex w-full items-center justify-center gap-2.5 rounded-default bg-brand-600 px-5 py-4 shadow-sm cursor-pointer">
              <svg
                className="font-['Inter'] text-[14px] font-[400] leading-[20px] text-neutral-0 w-6 h-6"
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
                <path
                  d="M12 22c5.523 0 10-4.477 10-10S17.523 2 12 2 2 6.477 2 12s4.477 10 10 10"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="2"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  strokeOpacity="1"
                />
              </svg>
              <span className="text-cta font-cta text-neutral-0">
                Confirm — Join Waitlist
              </span>
            </div>
            <div className="flex w-full items-center justify-center rounded-default border border-solid border-neutral-200 bg-neutral-0 px-5 py-3.5 cursor-pointer">
              <span className="text-cta font-cta text-neutral-600">Cancel</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}

export default ScrPatVoucher;
