<template>
  <textarea v-if="type === 'textarea'" class="v-textarea" v-model="value" :disabled="disabled"></textarea>
  <div v-else class="v-input" :class="{[`is-${size}`]: sizeMap[size]}">
    <input
      class="v-input-inner"
      v-model="value"
      :type="type"
      :disabled="disabled"
      @click="emitEvevt('click', $event)"
      @input="emitEvevt('input', $event)"
      @focus="emitEvevt('focus', $event)"
      @blur="emitEvevt('blur', $event)"
    />
  </div>
</template>

<script setup>
import {computed} from 'vue';

const props = defineProps({
  modelValue: {
    type: [String, Number],
  },
  type: {
    type: String,
    default: 'text',
  },
  size: {
    type: String,
  },
  disabled: {
    type: Boolean,
    default: false,
  },
});
const emit = defineEmits(['update:modelValue', 'input', 'focus', 'blur', 'click']);
const value = computed({
  get() {
    return props.modelValue;
  },
  set(val) {
    if (!props.disabled) {
      emit('update:modelValue', val);
    }
  },
});
const sizeMap = {
  large: true,
  small: true,
  mini: true,
};

function emitEvevt(name, e) {
  emit(name, e);
}
</script>

<style lang="less">
.v-input {
  --ipt-height: var(--height-default);

  .v-input-inner {
    width: 100%;
    height: var(--ipt-height);
    padding: 0 10px;
    border: 1px solid var(--color-border);
    border-radius: 4px;
    font-size: 14px;
    transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
    box-sizing: border-box;

    &:hover {
      border-color: var(--color-border-hover);
    }

    &[disabled] {
      background: var(--color-bg-disabled);
      border-color: var(--color-border-disabled);
      color: var(--color-disabled);
      cursor: not-allowed;
    }
    &::-webkit-outer-spin-button,
    &::-webkit-inner-spin-button {
      -webkit-appearance: none;
    }
  }

  &.is-large {
    --ipt-height: var(--height-large);
  }

  &.is-small {
    --ipt-height: var(--height-small);
  }

  &.is-mini {
    --ipt-height: var(--height-mini);
  }
}

.v-textarea {
  width: 100%;
  height: calc(var(--height-default) * 3);
  padding: 10px;
  border: 1px solid var(--color-border);
  border-radius: 4px;
  line-height: 1.5em;
  box-sizing: border-box;
  resize: vertical;
  overflow: auto;
  transition: border-color 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);

  &:hover {
    border-color: var(--color-border-hover);
  }
}
</style>
