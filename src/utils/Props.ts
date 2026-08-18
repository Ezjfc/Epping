export interface CommonProps {
  /**
   * class contains the Tailwind classes to apply on the outermost element.
   *
   * Important: this is limited to Tailwind, excluding CSS classes as Astro creates strict style
   *            scopes for separate components.
   */
  class?: string
}

// PickOptional is written Google AI Overview:
type PickOptional<T> = Pick<
  T,
  {
    [K in keyof T]-?: {} extends Pick<T, K> ? K : never;
  }[keyof T]
>;

export type Default<T> = Required<PickOptional<T>>
