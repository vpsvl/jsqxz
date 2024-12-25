<template>
  <div class="v-table v-table-meridian">
    <div class="thead">
      <div class="td">名称</div>
      <div class="td">经脉名称</div>
      <div class="td">奇穴</div>
    </div>
    <v-scroll class="tbody">
      <div v-for="parent of tbody" :key="parent.name">
        <div class="tr" v-for="(child, index) of parent.list" :key="child.name">
          <div class="td" :class="{'td-merge': index < parent.list.length - 1}">
            <span v-if="index === 1">{{ parent.name }}</span>
          </div>
          <div class="td">{{ child.name }}</div>
          <div class="td">
            <div class="td-block" v-for="item of child.list" :key="item.name">
              <div v-if="item.name">
                [
                <span class="color-error">{{ item.name }}</span>
                ]:
                <span class="color-success">{{ item.condition }}</span>
              </div>
              <div class="td-effect-item" v-for="(text, i) of item.effect" :key="i">
                {{ text }}
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="tr no-data" v-if="tbody.length < 1">
        <div class="td">{{ state.loading ? '加载中，请稍候...' : '暂无更多数据' }}</div>
      </div>
    </v-scroll>
  </div>
</template>

<script setup>
import {ref} from 'vue';
import meridianData from '@/data/meridian/index';

const tbody = ref(meridianData.list);
</script>

<style lang="less">
.v-table-meridian {
  .td {
    &.td-merge {
      border-bottom: 0;
    }
    &:nth-child(1) {
      flex: 0 0 100px;
    }
    &:nth-child(2) {
      flex: 0 0 100px;
    }
  }
}
</style>
