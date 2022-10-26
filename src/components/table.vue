<template>
  <div class="v-table">
    <div class="thead">
      <div class="td th-sort" v-for="th of cols" :key="th.key">
        <span>{{ th.name }}</span>
        <template v-if="th.sort">
          <i class="sort-arrow-up" :class="{active: sortActive === th.key + '-1'}" @click="sort(th.key, -1)"></i>
          <i class="sort-arrow-down" :class="{active: sortActive === th.key + 1}" @click="sort(th.key, 1)"></i>
        </template>
      </div>
    </div>
    <v-scroll class="tbody" v-if="data.length > 0">
      <transition-group name="sort">
        <div class="tr" v-for="(tr, index) of data" @click="clickTr(tr, index)" :key="tr.id ? tr.id : index">
          <div class="td" v-for="td of cols" :key="td.key">
            <slot :name="td.key" :row="tr" :index="index">
              <p v-if="typeof tr[td.key] !== 'object'">{{ tr[td.key] }}</p>
            </slot>
          </div>
        </div>
      </transition-group>
    </v-scroll>
    <div class="tr no-data" v-if="data.length <= 0">
      <div class="td">{{ state.loading ? '加载中，请稍候...' : '暂无更多数据' }}</div>
    </div>
  </div>
</template>

<script setup>
import {ref, inject, watchEffect} from 'vue';
import {onBeforeRouteLeave} from 'vue-router';

const props = defineProps({
  // 列 key, name, fixed, sort
  cols: {
    type: Array,
    default() {
      return [];
    },
  },
  // 表格内容
  data: {
    type: Array,
    default() {
      return [];
    },
  },
  // 是否显示加载中
  // loading: {
  //   type: Boolean,
  //   default: false,
  // },
});

const emit = defineEmits(['tr-click', 'sort']);
const state = inject('state');
const sortActive = ref('');

onBeforeRouteLeave(() => {
  sortActive.value = '';
});

function sort(key, direction) {
  sortActive.value = key + direction;
  emit('sort', key, direction);
}

function clickTr(row, index) {
  emit('tr-click', row, index);
}
</script>

<style lang="less"></style>
