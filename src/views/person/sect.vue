<template>
  <div class="v-table v-table-vertical">
    <div class="tr">
      <div class="td">名称</div>
      <div class="td">{{ tbody.name }}</div>
    </div>
    <div class="tr">
      <div class="td">特技</div>
      <div class="td">
        <div class="td-block">
          <div class="td-effect-item effect-icon-star" v-for="(item, index) of tbody.effect" :key="index">{{ item }}</div>
        </div>
      </div>
    </div>
    <div class="tr">
      <div class="td">天赋</div>
      <div class="td">
        <div class="td-block" v-for="(item, index) of tbody.talent" :key="index">
          <div v-if="item.name">
            [
            <span class="color-error">{{ item.name }}</span>
            ]:
            <span class="color-success">{{ item.condition }}</span>
          </div>
          <div class="td-effect-item effect-icon-rhombus" v-for="(text, i) of item.effect" :key="i">{{ text }}</div>
        </div>
      </div>
    </div>
    <div class="tr">
      <div class="td">
        <div class="td-block">武功</div>
        <div class="td-block color-success">*NPC处学习武功：中阶200贡献，高级400贡献，绝学600贡献</div>
        <div class="td-block color-success">*NPC处初阶中阶高阶可以一脉相承，绝学除轻功外都不能一脉相承</div>
      </div>
      <div class="td">
        <div class="td-block" v-for="(item, index) of tbody.martial" :key="index">
          <div v-if="item.name">
            [
            <span class="color-error">{{ item.name }}</span>
            ]:
          </div>
          <div class="td-effect-item" v-for="(text, i) of item.list" :key="i">{{ text }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import {ref, watchEffect, inject} from 'vue';
import {useRoute} from 'vue-router';

const route = useRoute();
const loading = inject('loading');

const tbody = ref({});
watchEffect(async () => {
  const {
    name,
    meta: {type},
  } = route;
  if (!/sect/i.test(name)) {
    return;
  }
  try {
    loading.value = true;
    const data = await import(`../../data/sect/${type}.js`);
    tbody.value = data.default;
    loading.value = false;
  } catch (e) {
    tbody.value = {};
    loading.value = false;
  }
});
</script>
