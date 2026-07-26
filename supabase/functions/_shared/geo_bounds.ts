/**
 * US App Store service area — contiguous states + Alaska, Hawaii, and
 * major US territories. Rejects arbitrary worldwide lat/lon to limit
 * paid-API abuse while allowing nationwide (not NJ-only) use.
 */

export type LatLonBox = {
  minLat: number;
  maxLat: number;
  minLon: number;
  maxLon: number;
};

/** Named boxes for clarity / future country packs. */
export const US_SERVICE_AREAS: ReadonlyArray<LatLonBox> = [
  // Contiguous 48 + DC (+ small border buffer)
  { minLat: 24.3, maxLat: 49.6, minLon: -125.2, maxLon: -66.7 },
  // Alaska (mainland + SE)
  { minLat: 51.0, maxLat: 71.5, minLon: -179.2, maxLon: -129.0 },
  // Aleutian Islands west of the antimeridian
  { minLat: 51.0, maxLat: 55.5, minLon: 172.0, maxLon: 180.0 },
  // Hawaii
  { minLat: 18.8, maxLat: 22.4, minLon: -160.6, maxLon: -154.6 },
  // Puerto Rico
  { minLat: 17.8, maxLat: 18.6, minLon: -67.4, maxLon: -65.1 },
  // US Virgin Islands
  { minLat: 17.6, maxLat: 18.5, minLon: -65.2, maxLon: -64.4 },
  // Guam
  { minLat: 13.2, maxLat: 13.7, minLon: 144.5, maxLon: 145.1 },
  // Northern Mariana Islands
  { minLat: 14.0, maxLat: 20.6, minLon: 144.8, maxLon: 146.2 },
  // American Samoa
  { minLat: -14.6, maxLat: -14.0, minLon: -171.2, maxLon: -168.0 },
] as const;

function inBox(latitude: number, longitude: number, box: LatLonBox): boolean {
  return (
    latitude >= box.minLat &&
    latitude <= box.maxLat &&
    longitude >= box.minLon &&
    longitude <= box.maxLon
  );
}

export function isInServiceArea(latitude: number, longitude: number): boolean {
  for (const box of US_SERVICE_AREAS) {
    if (inBox(latitude, longitude, box)) return true;
  }
  return false;
}

/** Approximate NJ state bbox for NJDOT AADT (NJ-only freight weight). */
export const NJ_BOUNDS: LatLonBox = {
  minLat: 38.85,
  maxLat: 41.45,
  minLon: -75.6,
  maxLon: -73.85,
};

export function isInNewJersey(latitude: number, longitude: number): boolean {
  return inBox(latitude, longitude, NJ_BOUNDS);
}
