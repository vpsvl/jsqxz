<template>
  <teleport to="body">
    <div class="v-loading" v-if="loading">
      <div class="v-loading-shape">
        <div class="shape shape-1"></div>
        <div class="shape shape-2"></div>
        <div class="shape shape-3"></div>
        <div class="shape shape-4"></div>
      </div>
    </div>
  </teleport>
</template>

<script setup>
const props = defineProps({
  // 是否显示加载中
  loading: {
    type: Boolean,
    default: false,
  },
});
</script>

<style lang="less">
.v-loading {
  position: fixed;
  top: 0;
  left: 0;
  z-index: 9;
  display: flex;
  align-items: center;
  justify-content: center;
  width: 100vw;
  height: 100vh;
  padding-bottom: 20vh;
  background: rgba(0, 0, 0, 0.1);
  .v-loading-shape {
    --width-shape: 30px;

    position: absolute;
    width: calc(2 * var(--width-shape));
    height: calc(2 * var(--width-shape));
    transform: rotate(45deg);
  }
  .shape {
    position: absolute;
    width: var(--width-shape);
    height: var(--width-shape);
    &:nth-child(1) {
      left: 0;
      background: var(--color-primary);
      animation: shape1 2s infinite reverse;
    }
    &:nth-child(2) {
      right: 0;
      background: var(--color-success);
      animation: shape2 2s infinite reverse;
    }
    &:nth-child(3) {
      bottom: 0;
      background: var(--color-warn);
      animation: shape3 2s infinite reverse;
    }
    &:nth-child(4) {
      bottom: 0;
      right: 0;
      background: var(--color-error);
      animation: shape4 2s infinite reverse;
    }
  }

  @keyframes shape1 {
    0% {
      transform: translate(0, 0);
    }
    25% {
      transform: translate(0, var(--width-shape));
    }
    50% {
      transform: translate(var(--width-shape), var(--width-shape));
    }
    75% {
      transform: translate(var(--width-shape), 0);
    }
  }

  @keyframes shape2 {
    0% {
      transform: translate(0, 0);
    }
    25% {
      transform: translate(calc(-1 * var(--width-shape)), 0);
    }
    50% {
      transform: translate(calc(-1 * var(--width-shape)), var(--width-shape));
    }
    75% {
      transform: translate(0, var(--width-shape));
    }
  }

  @keyframes shape3 {
    0% {
      transform: translate(0, 0);
    }
    25% {
      transform: translate(var(--width-shape), 0);
    }
    50% {
      transform: translate(var(--width-shape), calc(-1 * var(--width-shape)));
    }
    75% {
      transform: translate(0, calc(-1 * var(--width-shape)));
    }
  }

  @keyframes shape4 {
    0% {
      transform: translate(0, 0);
    }
    25% {
      transform: translate(0, calc(-1 * var(--width-shape)));
    }
    50% {
      transform: translate(calc(-1 * var(--width-shape)), calc(-1 * var(--width-shape)));
    }
    75% {
      transform: translate(calc(-1 * var(--width-shape)), 0);
    }
  }
}
</style>
