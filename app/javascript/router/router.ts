import Vue          from 'vue'
import VueRouter    from 'vue-router'
import ExpectedRaceIndex from '../components/pages/expected_race/index/index.vue'
import ExpectedRaceNew from '../components/pages/expected_race/new/new.vue'
import ExpectedRaceShow from '../components/pages/expected_race/show/show.vue'
import HorseIndex from '../components/pages/horse/index/index.vue'
import HorseNew from '../components/pages/horse/new/new.vue'

Vue.use(VueRouter)

const routes = [
  { path: '/expected_races',  name: 'ExpectedRaceIndex', component: ExpectedRaceIndex },
  { path: '/expected_races/new',  name: 'ExpectedRaceNew', component: ExpectedRaceNew },
  { path: '/expected_races/:race_id',  name: 'ExpectedRaceShow', component: ExpectedRaceShow, props: true },

  { path: '/horses', name: 'HorseIndex', component: HorseIndex },
  { path: '/horses/new', name: 'HorseNew', component: HorseNew },
];

export default new VueRouter(
  {
    mode: 'history',
    routes
  }
);