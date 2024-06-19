import { ReactNode } from "react";

export type ModalSizeType = "xs" | "sm" | "md" | "lg" | "xl" | "2xl" | "3xl" | "4xl" | "5xl" | "full";
export type ModalPropsType = {
  size: ModalSizeType,
  isOpen: boolean,
  onClose: () => void,
  children: ReactNode,
  title?: string | null
};
