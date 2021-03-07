import Vue          from 'vue'
import VueRouter    from 'vue-router'
import Sample     from '../components/pages/sample.vue'
import Sample2    from '../components/pages/sample-2.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/',  name: 'Sample', component: Sample },
  { path: '/sample_2',  name: 'Sample2', component: Sample2 },
];

export default new VueRouter(
  {
    mode: 'history',
    routes
  }
);