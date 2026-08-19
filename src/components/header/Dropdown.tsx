import { useFloating, useHover, useInteractions } from "@floating-ui/react";
import { useState, type PropsWithChildren } from "react";
import type { CommonProps } from "../../utils/props";

export type Props = PropsWithChildren<PropsWc>

interface PropsWc extends CommonProps {
}

export default function Dropdown({ children, class: c }: Props) {
  const [isOpen, setIsOpen] = useState(false)
  const { refs, floatingStyles, context } = useFloating({ open: isOpen, onOpenChange: setIsOpen })
  const hover = useHover(context)
  const { getReferenceProps, getFloatingProps } = useInteractions([hover])

  return (
    <>
      <button className={`${c} cursor-pointer`} ref={refs.setReference} {...getReferenceProps}>
      {children}
      {isOpen && (
        <div
        ref={refs.setFloating}
        style={floatingStyles}
        {...getFloatingProps()}
        >
        Floating element
        </div>
      )}
      </button>
      </>
  )
}
