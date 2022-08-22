<template>
  <div class="v-table">
    <div class="thead">
      <div class="td" v-for="th of cols" v-text="th.name" :key="th.key"></div>
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
import {onBeforeRouteLeave} from 'vue-router';

const props = defineProps({
  // 列 key, name, fixed
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

const emit = defineEmits(['tr-click']);
const loading = inject('loading');

function clickTr(row, index) {
  emit('tr-click', row, index);
}
</script>

<style lang="less"></style>
