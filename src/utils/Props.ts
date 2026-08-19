export interface CommonProps {
  /**
   * class contains the Tailwind or global class names to apply on the outermost element.
   *
   * Important: this is limited to Tailwind or global class names as Astro creates strict style
   *            scopes for separate components os children would not inherit styles from their
   *            parents.
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

export type Default<T> = Required<Omit<PickOptional<T>, "class">>
