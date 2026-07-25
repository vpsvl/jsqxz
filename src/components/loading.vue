<template>
  <teleport to="body">
    <div class="v-loading" v-if="loading">
      <span>加载中，请稍候...</span>
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
  background: rgba(0, 0, 0, 0.2);

  span {
    font-size: 20px;
    color: #fff;
  }
}
</style>
