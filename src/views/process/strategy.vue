<template>
  <v-tabs :list="data.list" :exclusive="data.exclusive">
    <template #tab="{tab}">
      <span :class="{[`level-${tab.level}`]: tab.level}">
        {{ tab.name }}
      </span>
    </template>
    <template #title="{info}">
      <span>作者:</span>
      <span :class="{[`level-${info.level}`]: info.level}">
        {{ info.name }}
      </span>
    </template>
    <template #default="{info}">
      <pre class="pre-log" style="font-size: 16px;">
        {{ info.content }}
      </pre>
    </template>
  </v-tabs>
</template>

<script setup>
import {ref} from 'vue';
import strategy from '@/data/strategy/index';

const data = ref(strategy);
</script>
