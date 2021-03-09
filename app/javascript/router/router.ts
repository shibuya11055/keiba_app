import Vue          from 'vue'
import VueRouter    from 'vue-router'
import ExpectedRaceIndex from '../components/pages/expected_race/index.vue'
import ExpectedRaceNew from '../components/pages/expected_race/new.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/',  name: 'ExpectedRaceIndex', component: ExpectedRaceIndex },
  { path: '/new',  name: 'ExpectedRaceNew', component: ExpectedRaceNew },
];

export default new VueRouter(
  {
    mode: 'history',
    routes
  }
);