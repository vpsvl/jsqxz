<template>
  <v-scroll class="menu" v-if="menus.length">
    <div class="menu-nav" v-for="route of menus" :key="route.name">
      <input class="nav-list-toggle" :value="route.name" v-model="slideMenu" type="checkbox" :id="route.name" />
      <template v-if="route.children && route.children.length">
        <label class="nav-title nav-item" :for="route.name">
          <p>{{route.meta.title}}</p>
          <em class="icon-arrow"></em>
        </label>
        <div class="nav-list" :style="{maxHeight: getChildHeight(route)}">
          <template v-for="child of route.children" :key="child.name">
            <router-link v-if="!child.meta || !child.meta.hidden" :to="{name: child.name}" class="nav-item">
              <p>{{child.meta.title}}</p>
            </router-link>
          </template>
        </div>
      </template>
      <router-link v-else :to="{name: route.name}" class="nav-item nav-title">
        <p>{{route.meta.title}}</p>
      </router-link>
    </div>
  </v-scroll>
</template>

<script setup>
import {computed, ref, watch, onBeforeMount} from 'vue';
import {useRoute} from 'vue-router';

const props = defineProps({
  menu: {
    type: Array,
    default() {
      return [];
    },
  },
});
const route = useRoute();
const menus = computed(() => props.menu.filter((item) => !item.meta || !item.meta.hidden));
const slideMenu = ref([]);
const getSlideDefault = () => {
  const {matched} = route;
  if (matched.length > 1) {
    slideMenu.value = [matched[1].name];
  }
};
onBeforeMount(() => {
  getSlideDefault();
});
watch(
  () => menus.value,
  (val) => {
    getSlideDefault();
  }
);

function getChildHeight(route) {
  if (route.children.length < 1) {
    return 0;
  }
  let newArr = route.children.filter((item) => !item.meta || !item.meta.hidden);
  return `${50 * newArr.length}px`;
}
</script>
<style lang="less">
.menu {
  --item-height: 40px;
  --item-padding-left: 20px;
  --bg-menu: #fff;
  --bg-menu-title: #fcfbfa;
  --bg-menu-active: var(--color-primary-lighter);
  --bg-menu-hover: var(--color-info-lighter);
  --time: 0.2s;

  position: relative;
  z-index: 2;
  flex-grow: 0;
  flex-shrink: 0;
  flex-basis: 190px;
  height: 100%;
  margin-right: 10px;
  background: var(--bg-menu);
  transition: all var(--time);
  .menu-nav .nav-list-toggle {
    &:checked ~ .nav-title .icon-arrow {
      &::before {
        transform: rotate(-50deg);
      }
      &::after {
        transform: rotate(50deg);
      }
    }
    &:not(:checked) ~ .nav-list {
      max-height: 0 !important;
    }
  }
  .nav-item {
    position: relative;
    display: block;
    height: var(--item-height);
    padding-left: var(--item-padding-left);
    line-height: var(--item-height);
    white-space: nowrap;
    color: #666;
    cursor: pointer;
    transition: all var(--time);
    &:hover {
      background: var(--bg-menu-hover);
    }
    &.nav-title {
      background: var(--bg-menu-title);
      height: var(--item-height);
      line-height: var(--item-height);
      font-size: 16px;
      color: var(--color-content);
    }
    &.router-link-active {
      background: var(--bg-menu-active);
      color: var(--color-link);

      &:hover {
        background: var(--bg-menu-active);
      }
    }
    .icon-arrow {
      position: absolute;
      top: 0;
      right: 0;
      display: block;
      width: 40px;
      height: var(--item-height);
      &::before {
        content: '';
        position: absolute;
        top: 20px;
        left: 12px;
        display: block;
        width: 10px;
        height: 1px;
        background: var(--color-gray);
        transform: rotate(50deg);
        transition: all var(--time);
      }
      &::after {
        content: '';
        position: absolute;
        top: 20px;
        left: 18px;
        display: block;
        width: 10px;
        height: 1px;
        background: var(--color-gray);
        transform: rotate(-50deg);
        transition: all var(--time);
      }
    }
  }
  .nav-list {
    overflow: hidden;
    transform-origin: top;
    transition: all var(--time);
    .nav-item {
      padding-left: calc(var(--item-padding-left) + 20px);
    }
  }
}
</style>
