// const params = ref({
//   name: '',
// });
// const scrollY = ref(0);
// const talentList = Object.values(data);
// const totalList = ref([]);
// const tbody = computed(() => {
//   return totalList.value.slice(
//     pageConfig.pageSize * (pageConfig.page - 1),
//     pageConfig.pageSize * pageConfig.page,
//   );
// });
// const pageConfig = reactive({
//   page: 1,
//   pageSize: 20,
//   total: computed(() => totalList.value.length),
// });

// function search() {
//   pageConfig.page = 1;
//   if (!params.value.name) {
//     totalList.value = [...talentList];
//     return;
//   }
//   totalList.value = talentList.filter((item) => {
//     return new RegExp(params.value.name, 'i').test(item.name);
//   });
// }

// function changePage() {
//   scrollY.value = scrollY.value === 0 ? 1 : 0;
// }

// onBeforeMount(() => {
//   search();
// });