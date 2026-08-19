import { safePolygon, useFloating, useFocus, useHover, useInteractions, useRole } from "@floating-ui/react";
import { useState, type PropsWithChildren, type ReactNode } from "react";
import type { CommonProps } from "../../utils/props";

export type Props = PropsWithChildren<PropsWc>

interface PropsWc extends CommonProps {
  /**
   * summary is the tree of elements to open the menu on hover or focus.
   */
  summary?: ReactNode
  /**
   * menu is the tree of elements to display as the menu.
   */
  menu?: ReactNode
}

export default function Dropdown({ class: c, summary, menu }: Props) {
  const [isOpen, setIsOpen] = useState(false)
  const { refs, floatingStyles, context } = useFloating({
    open: isOpen,
    onOpenChange: setIsOpen,
    placement: "bottom-start",
  })
  const hover = useHover(context, { handleClose: safePolygon() })
  const focus = useFocus(context)
  const role = useRole(context, { role: "menu" })
  const { getReferenceProps, getFloatingProps } = useInteractions([hover, focus, role])

  return (
    <>
      <button className={`${c} cursor-pointer`} ref={refs.setReference} {...getReferenceProps()}>
      {summary}
      </button>
      {isOpen && (
        <div ref={refs.setFloating} style={floatingStyles} {...getFloatingProps()}>
        {menu}
        </div>
      )}
      </>
  )
}
