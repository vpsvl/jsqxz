<template>
  <button class="v-button" :class="classList" :disabled="disabled" :type="nativeType">
    <slot></slot>
  </button>
</template>

<script setup>
import {computed} from 'vue';

const typeMap = {
  primary: true,
  success: true,
  warn: true,
  error: true,
  info: true,
};
const sizeMap = {
  large: true,
  small: true,
  mini: true,
};
const props = defineProps({
  type: {
    type: String,
  },
  size: {
    type: String,
  },
  plain: {
    type: Boolean,
    default: false,
  },
  round: {
    type: Boolean,
    default: false,
  },
  disabled: {
    type: Boolean,
    default: false,
  },
  nativeType: {
    type: String,
    default: 'button',
  },
});

const classList = computed(() => {
  let list = [];
  list.push(`v-button-${typeMap[props.type] ? props.type : 'default'}`);
  if (sizeMap[props.size]) {
    list.push(`is-${props.size}`);
  }
  if (props.plain) {
    list.push('is-plain');
  }
  if (props.round) {
    list.push('is-round');
  }
  return list;
});
</script>
<style lang="less">
.v-button {
  --btn-height: var(--height-default);
  --btn-color: var(--color-primary);
  --btn-color-light: var(--color-primary-light);
  --btn-color-lighter: var(--color-primary-lighter);

  display: inline-block;
  height: var(--btn-height);
  padding: 0 15px;
  background: var(--btn-color);
  border: 1px solid var(--btn-color);
  border-radius: 4px;
  color: #fff;
  font-size: 14px;
  text-align: center;
  line-height: 1em;
  box-sizing: border-box;
  cursor: pointer;
  transition: all 0.2s;

  &:hover {
    opacity: 0.8;
  }

  &.v-button-default {
    background: #fff;
    border-color: var(--color-border);
    color: var(--color-content);

    &:hover {
      background: var(--btn-color-lighter);
      border-color: var(--btn-color-light);
      color: var(--btn-color);
    }
  }

  &.is-plain {
    background: var(--btn-color-lighter);
    border-color: var(--btn-color-light);
    color: var(--btn-color);
  }

  &.v-button-success {
    --btn-color: var(--color-success);
    --btn-color-light: var(--color-success-light);
    --btn-color-lighter: var(--color-success-lighter);
  }

  &.v-button-warn {
    --btn-color: var(--color-warn);
    --btn-color-light: var(--color-warn-light);
    --btn-color-lighter: var(--color-warn-lighter);
  }

  &.v-button-error {
    --btn-color: var(--color-error);
    --btn-color-light: var(--color-error-light);
    --btn-color-lighter: var(--color-error-lighter);
  }

  &.v-button-info {
    --btn-color: var(--color-info);
    --btn-color-light: var(--color-info-light);
    --btn-color-lighter: var(--color-info-lighter);
  }

  &.is-round {
    border-radius: calc(var(--btn-height) / 2);
  }

  &.is-large {
    --btn-height: var(--height-large);
  }

  &.is-small {
    --btn-height: var(--height-small);
  }

  &.is-mini {
    --btn-height: var(--height-mini);
  }

  &[disabled] {
    opacity: 0.6;
    cursor: not-allowed !important;
  }
}
</style>
