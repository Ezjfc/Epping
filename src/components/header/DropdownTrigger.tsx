import { safePolygon, useFloating, useFocus, useHover, useInteractions, useRole } from "@floating-ui/react";
import { useState, type PropsWithChildren, type ReactNode } from "react";
import type { CommonProps } from "../../utils/props";

export type Props = PropsWithChildren<PropsWc>

interface PropsWc extends CommonProps {
  /**
   * menu is the tree of elements to display as the menu.
   */
  menu?: ReactNode
}

export default function Dropdown({ class: c, children, menu }: Props) {
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
      {isOpen && (
        <div ref={refs.setFloating} style={floatingStyles} {...getFloatingProps()}>
        {menu}
        </div>
      )}
      <button className={`${c} cursor-pointer`} ref={refs.setReference} {...getReferenceProps()}>
      {children}
      </button>
    </>
  )
}
