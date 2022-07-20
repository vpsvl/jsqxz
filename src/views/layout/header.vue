<template>
  <header class="header">
    <a class="header-logo" :href="homeUrl">
      <img src="../../assets/images/logo.png" alt="logo" />
    </a>
    <nav class="header-nav">
      <router-link v-for="(text, name) of headerNav" :key="name" :to="{name}">
        {{ text }}
      </router-link>
    </nav>
  </header>
</template>

<script setup>
import {headerNav} from '@/router/index';

const homeUrl = import.meta.env.PROD ? '/jsqxz' : '/';
</script>

<style lang="less">
.header {
  display: flex;
  flex-grow: 0;
  width: 100%;
  height: var(--header-height);
  margin-bottom: 10px;
  background: #fff;
  .header-logo {
    width: 200px;
    padding: 5px 0;
    text-align: center;
    img {
      height: 100%;
    }
  }
  .header-nav {
    display: flex;
    a {
      padding: 0 20px;
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
}
</style>
