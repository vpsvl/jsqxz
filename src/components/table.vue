<template>
  <div class="v-table">
    <div class="thead">
      <div class="td" :class="{'th-sort': th.sort}" v-for="th of cols" :key="th.key">
        <span>{{ th.name }}</span>
        <i class="sort-arrow-up" :class="{active: sortActive === th.key + 0}" @click="sort(th.key, 0)"></i>
        <i class="sort-arrow-down" :class="{active: sortActive === th.key + 1}" @click="sort(th.key, 1)"></i>
      </div>
    </div>
    <v-scroll class="tbody" v-if="data.length > 0">
      <div class="tr" v-for="(tr, index) of data" @click="clickTr(tr, index)" :key="index">
        <div class="td" v-for="td of cols" :key="td.key">
          <slot :name="`td-${td.key}`" :row="tr" :index="index">
            <p v-if="typeof tr[td.key] !== 'object'">{{ tr[td.key] }}</p>
          </slot>
        </div>
      </div>
    </v-scroll>
    <div class="tr no-data" v-if="data.length <= 0">
      <div class="td">{{ loading ? '加载中，请稍候...' : '暂无更多数据' }}</div>
    </div>
  </div>
</template>

<script setup>
import {ref, inject} from 'vue';

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
const loading = inject('loading');
const sortActive = ref('');

function sort(key, direction) {
  sortActive.value = key + direction;
  emit('sort', key, direction);
}

function clickTr(row, index) {
  emit('tr-click', row, index);
}
</script>

<style lang="less"></style>
