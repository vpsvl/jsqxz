<template>
  <div class="v-table v-table-process">
    <div class="thead">
      <div class="td">序号</div>
      <div class="td">流程</div>
      <div class="td">奖励</div>
    </div>
    <v-scroll :y="y0" class="tbody">
      <v-tbody-process :tbody="tbody.normal"></v-tbody-process>
      <template v-if="hasBranch">
        <div class="tr-branch">
          <label class="tr-branch-td" v-if="tbody.good?.length">
            <input type="radio" value="good" v-model="branch" />
            <span>正线</span>
          </label>
          <label class="tr-branch-td" v-if="tbody.evil?.length">
            <input type="radio" value="evil" v-model="branch" />
            <span>邪线</span>
          </label>
          <label class="tr-branch-td" v-if="tbody.branch?.length">
            <input type="radio" value="branch" v-model="branch" />
            <span>支线</span>
          </label>
        </div>
        <v-tbody-process :tbody="tbody.good" v-if="branch === 'good'"></v-tbody-process>
        <v-tbody-process :tbody="tbody.evil" v-if="branch === 'evil'"></v-tbody-process>
        <v-tbody-process :tbody="tbody.branch" v-if="branch === 'branch'"></v-tbody-process>
      </template>
    </v-scroll>
    <!-- <div class="tr no-data" v-if="tbody.normal?.length < 1">
      <div class="td">{{ loading ? '加载中，请稍候...' : '暂无更多数据' }}</div>
    </div> -->
  </div>
</template>

<script setup>
import {ref, watchEffect} from 'vue';
import {onBeforeRouteLeave, useRoute} from 'vue-router';
import VTbodyProcess from './tbody.vue';

const route = useRoute();
const loading = inject('loading');

const branch = ref('good');
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
  try {
    loading.value = true;
    const data = await import(`../../data/process/${type}.js`);
    tbody.value = data.default;
    loading.value = false;
  } catch (e) {
    tbody.value = {normal: []};
    loading.value = false;
  }
  hasBranch.value = tbody.value.good?.length || tbody.value.evil?.length || tbody.value.branch?.length;
  branch.value = 'good';
});

const y0 = ref(0);
onBeforeRouteLeave(() => {
  y0.value = y0.value === 0 ? 1 : 0;
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
