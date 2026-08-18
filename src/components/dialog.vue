<template>
  <teleport to="body">
    <dialog class="v-dialog" closedby="any" ref="dialogRef">
      <header class="v-dialog-header" v-show="header">
        <a href="javascript: void 0;" class="v-dialog-close" @click="close"></a>
        <slot name="header"></slot>
      </header>
      <div class="v-dialog-main">
        <slot></slot>
      </div>
      <footer class="v-dialog-footer" v-show="footer">
        <slot name="footer"></slot>
      </footer>
    </dialog>
  </teleport>
</template>
<script setup>
import {onMounted, useTemplateRef} from 'vue';

const props = defineProps({
  header: {
    type: Boolean,
    default: true,
  },
  footer: {
    type: Boolean,
    default: true,
  },
  width: {
    type: [Number, String],
  },
});
const dialogRef = useTemplateRef('dialogRef');

function show() {
  dialogRef.value.showModal();
  dialogRef.value.scrollTop = 0;
}

function close() {
  dialogRef.value.close();
}

onMounted(() => {
  if (props.width) {
    let width = props.width;
    if (typeof props.width === 'number') {
      width += 'px';
    }
    dialogRef.value.style.setProperty('--dialog-width', width);
  }
});
defineExpose({
  show,
  close,
});
</script>
<style lang="less">
.v-dialog {
  --dialog-width: auto;

  top: 50%;
  left: 50%;
  max-width: 80vw;
  width: var(--dialog-width);
  border: 0;
  border-radius: 4px;
  transform: translate(-50%, -50%);
  overflow-x: hidden;
  overflow-y: auto;

  &::-webkit-scrollbar {
    width: 6px;
  }

  &::-webkit-scrollbar-track {
    background: transparent;
  }

  &::-webkit-scrollbar-thumb {
    background: rgba(136, 136, 136, 0.5);
    border-radius: 3px;
  }

  &::-webkit-scrollbar-button {
    display: none;
  }

  .v-dialog-header {
    position: sticky;
    top: 0;
    z-index: 2;
    padding: 15px 10px 5px;
    background: #fff;
    font-size: 16px;
  }

  .v-dialog-main {
    padding: 10px;
  }

  .v-dialog-footer {
    position: sticky;
    bottom: 0;
    z-index: 2;
    padding: 5px 10px 10px;
    background: #fff;
  }

  .v-dialog-close {
    --icon-width: 16px;
    --icon-border: 2px;

    position: absolute;
    top: 15px;
    right: 10px;
    z-index: 3;
    width: var(--icon-width);
    height: var(--icon-width);
    transform: rotate(45deg);

    &::before {
      content: '';
      position: absolute;
      top: 0;
      left: calc((var(--icon-width) - var(--icon-border)) / 2);
      display: block;
      width: var(--icon-border);
      height: 100%;
      background: var(--color-error);
      border-radius: 1px;
    }

    &::after {
      content: '';
      position: absolute;
      left: 0;
      top: calc((var(--icon-width) - var(--icon-border)) / 2);
      display: block;
      height: var(--icon-border);
      width: 100%;
      background: var(--color-error);
      border-radius: 1px;
    }
  }
}
</style>