<template>
  <div class="bread-nav">
    <span class="nav-icon">当前位置:</span>
    <router-link :to="route" v-for="route of navLink" :key="route.name">
      {{ route.meta.title }}
    </router-link>
    <span>{{ navText.meta.title }}</span>
  </div>
</template>

<script setup>
import {ref, watchEffect} from 'vue';

const props = defineProps({
  nav: {
    type: Array,
    default() {
      return [];
    },
  },
});
const navLink = ref([]);
const navText = ref({});
watchEffect(() => {
  if (props.nav.length < 1) {
    navLink.value = [];
    navText.value = {};
    return;
  }
  navLink.value = [...props.nav];
  navText.value = navLink.value.pop();
});
</script>

<style lang="less">
.bread-nav {
  display: flex;
  align-items: center;
  width: 100%;
  height: var(--bread-height);
  margin-bottom: 10px;
  padding: 0 20px;
  background: #fff;
  .nav-icon {
    padding-right: 10px;
    color: var(--color-gray);
  }
  a {
    color: var(--color-link);
    &::after {
      content: '>';
      padding: 0 8px;
      color: var(--color-content);
    }
  }
}
</style>
