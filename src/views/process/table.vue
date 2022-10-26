<template>
  <div class="v-table v-table-process">
    <div class="thead">
      <div class="td">序号</div>
      <div class="td">流程</div>
      <div class="td">奖励</div>
    </div>
    <v-scroll class="tbody">
      <v-tbody-process :tbody="tbody.normal"></v-tbody-process>
      <template v-if="hasBranch">
        <div class="tr-branch">
          <label v-for="(name, val) in branchMap" class="tr-branch-td" :key="val">
            <input type="radio" :value="val" v-model="branch" />
            <span>{{ name }}</span>
          </label>
        </div>
        <v-tbody-process :tbody="tbody.good" v-if="branch === 'good'"></v-tbody-process>
        <v-tbody-process :tbody="tbody.evil" v-if="branch === 'evil'"></v-tbody-process>
        <v-tbody-process :tbody="tbody.branch" v-if="branch === 'branch'"></v-tbody-process>
      </template>
      <div class="tr no-data" v-if="tbody.normal?.length < 1">
        <div class="td">{{ state.loading ? '加载中，请稍候...' : '暂无更多数据' }}</div>
      </div>
    </v-scroll>
  </div>
</template>

<script setup>
import {ref, watchEffect, inject} from 'vue';
import {useRoute} from 'vue-router';
import VTbodyProcess from './tbody.vue';

const route = useRoute();
const state = inject('state');

const branch = ref('good');
const branchMap = ref({
  good: '正线',
  evil: '邪线',
  branch: '支线',
});
const goodMap = {
  shu: '霍青桐线',
  fei: '袁紫衣线',
};
const evilMap = {
  shu: '李沅芷线',
  fei: '程灵素线',
};
const hasBranch = ref(false);
const tbody = ref({});
watchEffect(async () => {
  const {
    name,
    meta: {type},
  } = route;
  if (!/process/i.test(name)) {
    return;
  }
  hasBranch.value = false;
  branchMap.value = {};
  try {
    state.loading = true;
    tbody.value = {normal: []};
    const data = await import(`../../data/process/${type}.js`);
    tbody.value = data.default;
    state.loading = false;
  } catch (e) {
    tbody.value = {normal: []};
    state.loading = false;
  }
  if (tbody.value.good?.length) {
    branchMap.value.good = goodMap[type] ? goodMap[type] : '正线';
    hasBranch.value = true;
  }
  if (tbody.value.evil?.length) {
    branchMap.value.evil = evilMap[type] ? evilMap[type] : '邪线';
    hasBranch.value = true;
  }
  if (tbody.value.branch?.length) {
    branchMap.value.branch = '支线';
    hasBranch.value = true;
  }
  branch.value = 'good';
});
</script>

<style lang="less">
.v-table-process {
  .tr-map {
    background: var(--color-success-lighter);
    color: var(--color-success);
    font-weight: 600;
  }
  .td {
    &:first-child {
      flex: 0 0 80px;
      justify-content: center;
    }
    &:last-child {
      flex: 0.5 0 0;
    }
  }
  .tr-branch {
    display: flex;
    height: 50px;
    background: var(--color-primary-lighter);
    border-bottom: 1px solid var(--color-border);
  }
  .tr-branch-td {
    cursor: pointer;
    span {
      display: block;
      height: 100%;
      padding: 0 40px;
      font-size: 16px;
      color: var(--color-primary);
      line-height: 50px;
      transition: all 0.2s;
      &:hover {
        background: var(--color-primary-light);
      }
    }
    input[type='radio']:checked + span {
      color: #fff;
      background: var(--color-primary);
    }
  }
}
</style>
