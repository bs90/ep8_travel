"use client"

import React from "react";
import {Modal, ModalContent, ModalHeader, ModalBody} from "@nextui-org/modal";
import { ModalPropsType } from "@/types/modal";



const NextUiModal = ({ size, isOpen, onClose, children, title }: ModalPropsType) => {
  return (
    <Modal
      size={ size }
      isOpen={ isOpen }
      onClose={ onClose }
    >
      <ModalContent>
        {() => (
          <>
            {
              !!title && <ModalHeader>
                { title }
              </ModalHeader>
            }
            <ModalBody>
              { children }
            </ModalBody>
          </>
        )}
      </ModalContent>
    </Modal>
  )
}

export default NextUiModal;
