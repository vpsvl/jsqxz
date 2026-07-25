<template>
  <v-tabs :list="data.list">
    <template #tab="{tab}">
      <span class="level-4">
        {{ tab.name }}
      </span>
    </template>
    <template #title="{info}">
      <span class="level-4">
        {{ info.name }}
      </span>
    </template>
    <template #default="{info}">
      <div class="v-table">
        <div class="td-effect-item effect-icon-rhombus" v-for="(text, i) of info.info" :key="i">
          {{ text }}
        </div>
      </div>
    </template>
  </v-tabs>
</template>

<script setup>
import data from '@/v107/data/other/system';
</script>
