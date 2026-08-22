import { safePolygon, size, useFloating, useFocus, useHover, useInteractions, useRole } from "@floating-ui/react";
import { useState, type PropsWithChildren, type ReactNode } from "react";
import type { CommonPropsReact } from "../../utils/props";

export type Props = PropsWithChildren<PropsWc>

interface PropsWc extends CommonPropsReact {
  /**
   * menu is the tree of elements to display as the menu.
   */
  menu?: ReactNode
}

export default function Dropdown({ className, children, menu }: Props) {
  const [isOpen, setIsOpen] = useState(false)
  const { refs, floatingStyles, context } = useFloating({
    open: isOpen,
    onOpenChange: setIsOpen,
    placement: "bottom-start",
    middleware: [
      size({
        apply({ rects, elements }) {
          Object.assign(elements.floating.style, {
            minWidth: `${rects.reference.width}px`,
          })
        }
      })
    ]
  })
  const hover = useHover(context, { handleClose: safePolygon() }) // TODO: switch to floatingportal and focus manager
  const focus = useFocus(context)
  const role = useRole(context, { role: "menu" })
  const { getReferenceProps, getFloatingProps } = useInteractions([hover, focus, role])

  return (
    <div className={className} >
      {isOpen && (
        <div className="menu" ref={refs.setFloating} style={floatingStyles} {...getFloatingProps()}>
        {menu}
        </div>
      )}
      <button className="summary cursor-pointer group" ref={refs.setReference} {...getReferenceProps()}>
      {children}
      </button>
    </div>
  )
}
