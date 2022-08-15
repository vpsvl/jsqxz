<template>
  <teleport to="body">
    <div class="v-loading" v-if="loading"></div>
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
  width: 100vw;
  height: 100vh;
  background: transparent;
}
</style>
