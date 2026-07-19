<template>
  <header class="header">
    <a
      v-if="!state.lessWindow"
      class="header-logo"
      href="javascript: void 0"
      @click="goHome"
    >
      <img src="../../assets/images/logo.png" alt="logo"/>
    </a>
    <a
      class="header-menu-switch"
      :class="{'icon-hidden': route.name === 'index'}"
      href="javascript: void 0;"
      @click="toggleMenu"
      v-if="state.lessWindow"
    >
      <svg
        xmlns="http://www.w3.org/2000/svg"
        aria-hidden="true"
        focusable="false"
        viewBox="0 0 24 24"
      >
        <path d="M17,11H3c-0.6,0-1-0.4-1-1s0.4-1,1-1h14c0.6,0,1,0.4,1,1S17.6,11,17,11z"></path>
        <path d="M21,7H3C2.4,7,2,6.6,2,6s0.4-1,1-1h18c0.6,0,1,0.4,1,1S21.6,7,21,7z"></path>
        <path d="M21,15H3c-0.6,0-1-0.4-1-1s0.4-1,1-1h18c0.6,0,1,0.4,1,1S21.6,15,21,15z"></path>
        <path d="M17,19H3c-0.6,0-1-0.4-1-1s0.4-1,1-1h14c0.6,0,1,0.4,1,1S17.6,19,17,19z"></path>
      </svg>
    </a>
    <nav class="header-nav">
      <router-link v-for="(text, name) of navList" :key="name" :to="{name}">
        {{ text }}
      </router-link>
    </nav>
    <div class="header-version">
      <select v-model="state.version" class="version-select" @change="goHome">
        <option v-for="(name, val) in state.versionAll" :key="val" :value="val">
          {{ name }}
        </option>
      </select>
    </div>
  </header>
</template>

<script setup>
import {inject, ref, watch} from 'vue';
import {headerNav} from '@/router/index.js';
import {useRoute, useRouter} from 'vue-router';

const route = useRoute();
const router = useRouter();
const state = inject('state');
const navList = ref([]);

watch(() => state.version, val => {
  navList.value = headerNav[val] ? headerNav[val] : [];
}, {immediate: true});

function goHome() {
  router.push({name: `index${state.version}`});
}

function toggleMenu() {
  state.menuVisible = !state.menuVisible;
}
</script>

<style lang="less">
.is-less-window .header {
  --nav-padding-h: 8px;

  .version-select {
    width: 70px;
  }
}

.header {
  --nav-padding-h: 16px;

  position: relative;
  z-index: 9;
  display: flex;
  flex-grow: 0;
  width: 100%;
  height: var(--header-height);
  margin-bottom: 10px;
  background: #fff;

  .header-logo {
    width: calc(var(--menu-width) + 10px);
    height: 100%;
    padding: 5px 0;
    text-align: center;
    overflow: hidden;

    img {
      height: 100%;
    }
  }

  .header-menu-switch {
    display: flex;
    align-items: center;
    justify-content: center;
    width: var(--header-height);
    height: 100%;
    background: #fff;

    &.icon-hidden {
      opacity: 0;
    }

    svg {
      width: 30px;
      height: 30px;
    }

    path {
      fill: var(--color-primary);
    }
  }

  .header-nav {
    display: flex;
    flex: 1 0 0;

    a {
      padding: 0 var(--nav-padding-h);
      font-size: 16px;
      line-height: var(--header-height);
      overflow: hidden;

      &:hover {
        background: #f3f3f3;
      }

      &.router-link-active {
        color: var(--color-link);
        background: var(--color-primary-lighter);
      }
    }
  }

  .header-version {
    display: flex;
    align-items: stretch;
    margin-right: 10px;
  }

  .version-select {
    appearance: base-select;
    display: flex;
    align-items: center;
    width: 80px;
    padding: 0 5px;
    border: 0;
    background: #fff;
    cursor: pointer;

    &::picker(select) {
      appearance: base-select;
      border-radius: 4px;
      border-color: var(--color-border);
    }

    &:hover {
      background: #fff;
    }

    option {
      padding: 5px;

      &:checked {
        background: var(--color-primary-light);
      }
    }
  }
}
</style>
