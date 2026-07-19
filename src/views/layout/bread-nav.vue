<template>
  <div class="bread-nav">
    <span class="nav-icon">当前位置:</span>
    <template v-for="(route, index) of navLink" :key="route.name">
      <i v-if="index > 0">&gt;</i>
      <router-link v-if="route.type === 'link'" :to="route">
        {{ route.meta.title }}
      </router-link>
      <span v-if="route.type === 'text'">{{ route.meta.title }}</span>
    </template>

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
watchEffect(() => {
  const length = props.nav.length;
  if (length < 1) {
    navLink.value = [];
    return;
  }
  navLink.value = props.nav.map((item, index) => {
    item.type = index === 0 || index === length - 1 ? 'text' : 'link';
    return item;
  });
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
  }

  i {
    font-style: normal;
    padding: 0 8px;
    color: var(--color-content);
  }
}
</style>
