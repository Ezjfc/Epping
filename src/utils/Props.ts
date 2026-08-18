export default interface BaseProps {
  /**
   * class contains the Tailwind classes to apply on the outermost element.
   *
   * Important: this is limited to Tailwind, excluding CSS classes as Astro creates strict style
   *            scopes for separate components.
   */
  class?: string
}
