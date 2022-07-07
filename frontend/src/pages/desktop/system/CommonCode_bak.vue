<template>
  <div>
    <q-splitter
      v-model="splitterModel"
      :limits='[20,50]'
      style="height: 100%"
    >

      <template v-slot:before>
        <div class="q-pa-lg">
          <div class="text-h4 q-mb-md">Before</div>
          <q-input outlined v-model="code_id" label="코드" />
          <q-input outlined v-model="code_name" label="코드명" />
          <q-select outlined filled v-model="parent_code_id" :options="options" label="상위 카테고리" />
          <q-input outlined v-model="order_idx" label="정렬 순서" />
          <q-input outlined v-model="explanation" label="설명" />
          <q-toggle outlined left-label label="설명" v-model="enabled" />
          <q-input outlined v-model="etc" label="기타" />
          <q-btn color="secondary" label="등록" />
        </div>

      </template>

      <template v-slot:after>
        <div class="q-pa-md">
          <div class="text-h4 q-mb-md"></div>
          <div class="q-pa-md">
            <q-table
              class="my-sticky-header-table"
              title="코드 전체"
              :rows="rows"
              :columns="columns"
              row-key="name"
              :selected-rows-label="getSelectedString"
              selection='multiple'
              v-model:selected='selected'
              v-model:pagination="pagination"
              :rows-per-page-options="[0]"
              flat
              bordered
            />
            <div class="q-mt-md">
              Selected: {{ JSON.stringify(selected) }}
            </div>
          </div>
        </div>
      </template>

    </q-splitter>
  </div>
</template>

<script>
import { computed, onMounted, ref } from 'vue'
import { PartnerItem } from '../../../types'
import dialog from '../../../utils/dialog'

export const code_id = ref('')
export const options = ref('카테고리1','카테고리2')

export default {
  setup () {
    const selected = ref([])

    return {
      code_name: ref(''),
      order_idx: ref(''),
      explanation: ref(''),
      enabled: ref('ture'),
      etc: ref(''),
      dense: ref(false),
      parent_code_id:ref('카테고리 선택'),
      selected,
      columns,
      rows,
      //options:['카테고리1', '카테고리2', '카테고리3', '카테고리4'],
      splitterModel: ref(30), // start at 50%
      getSelectedString() {
        return selected.value.length === 0 ? '' : `${selected.value.length} record${selected.value.length > 1 ? 's' : ''} selected of ${rows.length}`
      },
      pagination: ref({
        rowsPerPage: 15
      })
    }
  }
}

const columns = [
  {
    name: 'name',
    label: '상위코드',
    align: 'center',
    field: row => row.parent_code_id,
    format: val => `${val}`,
    sortable: true
  },
  { name: '상위코드명', align: 'center', label: '상위코드명', field: 'parent_code_name', sortable: true },
  { name: '코드', required: true, align: 'center', label: '코드', field: 'code_id' },
  { name: '코드명', align: 'center', label: '코드명', field: 'code_name' },
  { name: '설명', align: 'center', label: '설명', field: 'explanation' },
  { name: '기타', align: 'center', label: '기타', field: 'etc', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: '사용여부', align: 'center', label: '사용여부', field: 'enabled', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) },
  { name: '수정', align: 'center', label: '수정', field: 'iron', sortable: true, sort: (a, b) => parseInt(a, 10) - parseInt(b, 10) }
]
const rows = [
  {parent_code_id: '-',         parent_code_name: '-',             code_id: '00',            code_name: 'ADMIN',                explanation: '기술담당자'                    ,etc: '기술 담당자',enabled: 1},
  {parent_code_id: 0,         parent_code_name: 'ADMIN',         code_id: '0000',          code_name: 'DMA001',             explanation: '송미경'                       ,etc: '학예연구1팀 학예연구사 송미경',enabled: 1},
  {parent_code_id: 0,         parent_code_name: 'ADMIN',         code_id: '0001',          code_name: 'DMA002',             explanation: '김재영'                       ,etc: '기록물관리전문가 김재영',enabled: 1},
  {parent_code_id: '-',         parent_code_name: '-',             code_id: 10,            code_name: 'ADMIN_GROUP',          explanation: '부서명'                       ,etc: 'DJC',enabled: 1},
  {parent_code_id: 10,        parent_code_name: 'ADMIN_GROUP',   code_id: 1000,          code_name: 'CURATED_RESEARCH',   explanation: '학예연구1팀'                  ,etc: '',enabled: 1},
  {parent_code_id: 10,        parent_code_name: 'ADMIN_GROUP',   code_id: 1010,          code_name: '기록물관리전문가',       explanation: '기록물관리전문가'              ,etc: '',enabled: 1},
  {parent_code_id: '-',         parent_code_name: '-',             code_id: 20,            code_name: 'AUTHOR',               explanation: '작가'                       ,etc: 'DJC',enabled: 1},
  {parent_code_id: 20,        parent_code_name: 'AUTHOR',        code_id: 2000,          code_name: 'DJC2021.01',      explanation: '임봉재'                       ,etc: '임봉재',enabled: 1},
  {parent_code_id: 20,        parent_code_name: 'AUTHOR',        code_id: 2010,          code_name: 'DJC2021.02',      explanation: '김철호'                       ,etc: '김철호',enabled: 1},
  {parent_code_id: '-',         parent_code_name: '-',             code_id: 30,            code_name: 'COM',             explanation: '컴포넌트'                       ,etc: '컴포넌트 그룹',enabled: 1},
  {parent_code_id: 30,        parent_code_name: 'COM',           code_id: 3000,          code_name: 'TECH',            explanation: '기술레벨'                       ,etc: '[ 컬렉선 | 시리즈 | 아이템 | 컴포넌트 ]',enabled: 1},
  {parent_code_id: 3000,      parent_code_name: 'TECH',          code_id: 300000,        code_name: 'COLLECTION',      explanation: '컬렉션'                       ,etc: '컴포넌트-기술레벨-컬렉션',enabled: 1},
  {parent_code_id: 3000,      parent_code_name: 'TECH',          code_id: 300010,        code_name: 'SERIES',          explanation: '시리즈'                       ,etc: '컴포넌트-기술레벨-시리즈',enabled: 1},
  {parent_code_id: 3000,      parent_code_name: 'TECH',          code_id: 300020,        code_name: 'ITEM',            explanation: '아이템'                       ,etc: '컴포넌트-기술레벨-아이템',enabled: 1},
  {parent_code_id: 3000,      parent_code_name: 'TECH',          code_id: 300030,        code_name: 'COMPONENT',       explanation: '컴포넌트'                       ,etc: '컴포넌트-기술레벨-컴포넌트',enabled: 1},
  {parent_code_id: 30,        parent_code_name: 'COM',           code_id: 3010,          code_name: 'LANGUAGE',        explanation: '언어'                       ,etc: '[ 한국어 | 영어 | 중국어 | 일본어 ]',enabled: 1},
  {parent_code_id: 3010,      parent_code_name: 'LANGUAGE',      code_id: 301000,        code_name: 'KR',              explanation: '한국어'                       ,etc: '컴포넌트-언어-한국어',enabled: 1},
  {parent_code_id: 3010,      parent_code_name: 'LANGUAGE',      code_id: 301001,        code_name: 'EN',              explanation: '영어'                       ,etc: '컴포넌트-언어-영어',enabled: 1},
  {parent_code_id: 3010,      parent_code_name: 'LANGUAGE',      code_id: 301002,        code_name: 'CH',              explanation: '중국어'                       ,etc: '컴포넌트-언어-중국어',enabled: 1},
  {parent_code_id: 3010,      parent_code_name: 'LANGUAGE',      code_id: 301003,        code_name: 'JP',              explanation: '일본어'                       ,etc: '컴포넌트-언어-일본어',enabled: 1},
  {parent_code_id: 30,        parent_code_name: 'COM',           code_id: 3020,          code_name: 'TYPE',            explanation: '컴포넌트- 유형'                       ,etc: '[ 전시인쇄물 | 간행물 | 일반문서 | 증빙서류 | 사문서 | 시청각자료 | 디지털파일 | 판화류 | 도면 | 모형 | 오브제 | 벽보류 | 지도 | 화구 | 상패류 | 기념품 ]',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302000,        code_name: 'Ⅰ',               explanation: '컴포넌트-유형-전시인쇄물'                       ,etc: '[ 브로슈어 | 리플릿 | 초대장 | 포스터 | 초대권 | 도록 | 안내문 ]',enabled: 1},
  {parent_code_id: 302000,    parent_code_name: 'PRINTS',        code_id: 30200000,      code_name: 'a',               explanation: '브로슈어'                       ,etc: '컴포넌트-유형-전시인쇄물-브로슈어',enabled: 1},
  {parent_code_id: 302000,    parent_code_name: 'PRINTS',        code_id: 30200001,      code_name: 'b',               explanation: '리플릿'                       ,etc: '컴포넌트-유형-전시인쇄물-리플릿',enabled: 1},
  {parent_code_id: 302000,    parent_code_name: 'PRINTS',        code_id: 30200002,      code_name: 'c',               explanation: '초대장'                       ,etc: '컴포넌트-유형-전시인쇄물-초대장',enabled: 1},
  {parent_code_id: 302000,    parent_code_name: 'PRINTS',        code_id: 30200003,      code_name: 'd',               explanation: '포스터'                       ,etc: '컴포넌트-유형-전시인쇄물-포스터',enabled: 1},
  {parent_code_id: 302000,    parent_code_name: 'PRINTS',        code_id: 30200004,      code_name: 'e',               explanation: '초대권'                       ,etc: '컴포넌트-유형-전시인쇄물-초대권',enabled: 1},
  {parent_code_id: 302000,    parent_code_name: 'PRINTS',        code_id: 30200005,      code_name: 'f',               explanation: '도록'                       ,etc: '컴포넌트-유형-전시인쇄물-도록',enabled: 1},
  {parent_code_id: 302000,    parent_code_name: 'PRINTS',        code_id: 30200006,      code_name: 'g',               explanation: '안내문'                       ,etc: '컴포넌트-유형-전시인쇄물-안내문',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302010,        code_name: 'Ⅱ',               explanation: '컴포넌트-유형-간행물'                       ,etc: '[ 신문 | 잡지 | 학술지 | 회보 | 도서 | 논문 ]',enabled: 1},
  {parent_code_id: 302010,    parent_code_name: 'PUBLIC',        code_id: 30201000,      code_name: 'a',               explanation: '신문'                       ,etc: '컴포넌트-유형-간행물-신문',enabled: 1},
  {parent_code_id: 302010,    parent_code_name: 'PUBLIC',        code_id: 30201001,      code_name: 'b',               explanation: '잡지'                       ,etc: '컴포넌트-유형-간행물-잡지',enabled: 1},
  {parent_code_id: 302010,    parent_code_name: 'PUBLIC',        code_id: 30201002,      code_name: 'c',               explanation: '학술지'                       ,etc: '컴포넌트-유형-간행물-학술지',enabled: 1},
  {parent_code_id: 302010,    parent_code_name: 'PUBLIC',        code_id: 30201003,      code_name: 'd',               explanation: '회보'                       ,etc: '컴포넌트-유형-간행물-회보',enabled: 1},
  {parent_code_id: 302010,    parent_code_name: 'PUBLIC',        code_id: 30201004,      code_name: 'e',               explanation: '도서'                       ,etc: '컴포넌트-유형-간행물-도서',enabled: 1},
  {parent_code_id: 302010,    parent_code_name: 'PUBLIC',        code_id: 30201005,      code_name: 'f',               explanation: '논문'                       ,etc: '컴포넌트-유형-간행물-논문',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302015,        code_name: 'Ⅲ',               explanation: '일반문서'                       ,etc: '[ 공문서 | 회의자료 | 녹취록 | 강의록 | 자료집 | 선언문 | 발표문 | 보고서 | 제안서 | 안내문 | 정관 | 명부 | 연혁 | 일정표 | 추천서 | 보도자료 | 미술인카드 | 이력서 | 포트폴리오 | 설계설명서 | 시방서 | 홍보물 | 활동지 | 기타분류',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201500,      code_name: 'a',               explanation: '공문서'                       ,etc: '컴포넌트-유형-일반문서-공문서',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201501,      code_name: 'b',               explanation: '회의자료'                       ,etc: '컴포넌트-유형-일반문서-회의자료',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201502,      code_name: 'c',               explanation: '녹취록'                       ,etc: '컴포넌트-유형-일반문서-녹취록',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201503,      code_name: 'd',               explanation: '강의록'                       ,etc: '컴포넌트-유형-일반문서-강의록',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201504,      code_name: 'e',               explanation: '자료집'                       ,etc: '컴포넌트-유형-일반문서-자료집',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201505,      code_name: 'f',               explanation: '선언문'                       ,etc: '컴포넌트-유형-일반문서-선언문',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201506,      code_name: 'g',               explanation: '발표문'                       ,etc: '컴포넌트-유형-일반문서-발표문',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201507,      code_name: 'h',               explanation: '보고서'                       ,etc: '컴포넌트-유형-일반문서-보고서',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201508,      code_name: 'i',               explanation: '제안서'                       ,etc: '컴포넌트-유형-일반문서-제안서',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201509,      code_name: 'j',               explanation: '안내문'                       ,etc: '컴포넌트-유형-일반문서-안내문',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201510,      code_name: 'k',               explanation: '정관'                       ,etc: '컴포넌트-유형-일반문서-정관',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201511,      code_name: 'l',               explanation: '명부'                       ,etc: '컴포넌트-유형-일반문서-명부',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201512,      code_name: 'm',               explanation: '연혁'                       ,etc: '컴포넌트-유형-일반문서-연혁',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201513,      code_name: 'n',               explanation: '일정표'                       ,etc: '컴포넌트-유형-일반문서-일정표',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201514,      code_name: 'o',               explanation: '추천서'                       ,etc: '컴포넌트-유형-일반문서-추천서',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201515,      code_name: 'p',               explanation: '보도자료'                       ,etc: '컴포넌트-유형-일반문서-보도자료',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201516,      code_name: 'q',               explanation: '미술인카드'                       ,etc: '컴포넌트-유형-일반문서-미술인카드',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201517,      code_name: 'r',               explanation: '이력서'                       ,etc: '컴포넌트-유형-일반문서-이력서',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201518,      code_name: 's',               explanation: '포트폴리오'                       ,etc: '컴포넌트-유형-일반문서-포트폴리오',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201519,      code_name: 't',               explanation: '설계설명서'                       ,etc: '컴포넌트-유형-일반문서-설계설명서',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201520,      code_name: 'u',               explanation: '시방서'                       ,etc: '컴포넌트-유형-일반문서-시방서',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201521,      code_name: 'v',               explanation: '홍보물'                       ,etc: '컴포넌트-유형-일반문서-홍보물',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201522,      code_name: 'w',               explanation: '활동지'                       ,etc: '컴포넌트-유형-일반문서-활동지',enabled: 1},
  {parent_code_id: 302015,    parent_code_name: 'DOC',           code_id: 30201523,      code_name: 'x',               explanation: '기타분류'                       ,etc: '컴포넌트-유형-일반문서-기타분류',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302020,        code_name: 'Ⅳ',               explanation: '증빙서류'                       ,etc: '[설치메뉴얼 | 확인서 | 감정서 | 인수증 | 증명서 | 약정서]',enabled: 1},
  {parent_code_id: 302020,    parent_code_name: 'DOCEV',         code_id: 30202000,      code_name: 'a',               explanation: '설치메뉴얼'                       ,etc: '컴포넌트-유형-증빙서류-설치메뉴얼',enabled: 1},
  {parent_code_id: 302020,    parent_code_name: 'DOCEV',         code_id: 30202001,      code_name: 'b',               explanation: '확인서'                       ,etc: '컴포넌트-유형-증빙서류-확인서',enabled: 1},
  {parent_code_id: 302020,    parent_code_name: 'DOCEV',         code_id: 30202002,      code_name: 'c',               explanation: '감정서'                       ,etc: '컴포넌트-유형-증빙서류-감정서',enabled: 1},
  {parent_code_id: 302020,    parent_code_name: 'DOCEV',         code_id: 30202003,      code_name: 'd',               explanation: '인수증'                       ,etc: '컴포넌트-유형-증빙서류-인수증',enabled: 1},
  {parent_code_id: 302020,    parent_code_name: 'DOCEV',         code_id: 30202004,      code_name: 'e',               explanation: '증명서'                       ,etc: '컴포넌트-유형-증빙서류-증명서',enabled: 1},
  {parent_code_id: 302020,    parent_code_name: 'DOCEV',         code_id: 30202005,      code_name: 'f',               explanation: '약정서'                       ,etc: '컴포넌트-유형-증빙서류-약정서',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302025,        code_name: 'Ⅴ',               explanation: '사문서'                       ,etc: '[편지 | 이메일 | 팩스 | 엽서 | 일기 | 작가노트 | 메모 | 드로잉 | 스크랩 | 수첩 | 원고 | 방명록 | 명함 | 기타분류]',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202500,      code_name: 'a',               explanation: '편지'                       ,etc: '컴포넌트-유형-사문서-편지',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202501,      code_name: 'b',               explanation: '이메일'                       ,etc: '컴포넌트-유형-사문서-이메일',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202502,      code_name: 'c',               explanation: '팩스'                       ,etc: '컴포넌트-유형-사문서-팩스',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202503,      code_name: 'd',               explanation: '엽서'                       ,etc: '컴포넌트-유형-사문서-엽서',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202504,      code_name: 'e',               explanation: '일기'                       ,etc: '컴포넌트-유형-사문서-일기',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202505,      code_name: 'f',               explanation: '작가노트'                       ,etc: '컴포넌트-유형-사문서-작가노트',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202506,      code_name: 'g',               explanation: '메모'                       ,etc: '컴포넌트-유형-사문서-메모',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202507,      code_name: 'h',               explanation: '드로잉'                       ,etc: '컴포넌트-유형-사문서-드로잉',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202508,      code_name: 'i',               explanation: '스크랩'                       ,etc: '컴포넌트-유형-사문서-스크랩',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202509,      code_name: 'j',               explanation: '수첩'                       ,etc: '컴포넌트-유형-사문서-수첩',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202510,      code_name: 'k',               explanation: '원고'                       ,etc: '컴포넌트-유형-사문서-원고',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202511,      code_name: 'l',               explanation: '방명록'                       ,etc: '컴포넌트-유형-사문서-방명록',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202512,      code_name: 'm',               explanation: '명함'                       ,etc: '컴포넌트-유형-사문서-명함',enabled: 1},
  {parent_code_id: 302025,    parent_code_name: 'PRIPAPAER',     code_id: 30202513,      code_name: 'n',               explanation: '기타분류'                       ,etc: '컴포넌트-유형-사문서-기타분류',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302030,        code_name: 'Ⅵ',               explanation: '시청각자료'                       ,etc: '[사진 | 슬라이드 | 사진필름 | 영화필름 | 마이크로필름 | 비디오테이프 | 오디오테이프 | 광디스크 | 음반 | 플래시메모리]',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203000,      code_name: 'a',               explanation: '사진'                       ,etc: '컴포넌트-유형-시청각자료-사진',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203001,      code_name: 'b',               explanation: '슬라이드'                       ,etc: '컴포넌트-유형-시청각자료-슬라이드',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203002,      code_name: 'c',               explanation: '사진필름'                       ,etc: '컴포넌트-유형-시청각자료-사진필름',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203003,      code_name: 'd',               explanation: '영화필름'                       ,etc: '컴포넌트-유형-시청각자료-영화필름',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203004,      code_name: 'e',               explanation: '마이크로필름'                       ,etc: '컴포넌트-유형-시청각자료-마이크로필름',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203005,      code_name: 'f',               explanation: '비디오테이프'                       ,etc: '컴포넌트-유형-시청각자료-비디오테이프',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203006,      code_name: 'g',               explanation: '오디오테이프'                       ,etc: '컴포넌트-유형-시청각자료-오디오테이프',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203007,      code_name: 'h',               explanation: '광디스크'                       ,etc: '컴포넌트-유형-시청각자료-광디스크',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203008,      code_name: 'i',               explanation: '음반'                       ,etc: '컴포넌트-유형-시청각자료-음반',enabled: 1},
  {parent_code_id: 302030,    parent_code_name: 'AUDIOVISUAL',   code_id: 30203009,      code_name: 'j',               explanation: '플래시메모리'                       ,etc: '컴포넌트-유형-시청각자료-플래시메모리',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302035,        code_name: 'Ⅶ',               explanation: '디지털파일'                       ,etc: '[비디오 | 오디오 | 이미지 | 텍스트 | 3D파일]',enabled: 1},
  {parent_code_id: 302035,    parent_code_name: 'DIGITAL',       code_id: 30203500,      code_name: 'a',               explanation: '비디오'                       ,etc: '컴포넌트-유형-디지털파일-비디오',enabled: 1},
  {parent_code_id: 302035,    parent_code_name: 'DIGITAL',       code_id: 30203501,      code_name: 'b',               explanation: '오디오'                       ,etc: '컴포넌트-유형-디지털파일-오디오',enabled: 1},
  {parent_code_id: 302035,    parent_code_name: 'DIGITAL',       code_id: 30203502,      code_name: 'c',               explanation: '이미지'                       ,etc: '컴포넌트-유형-디지털파일-이미지',enabled: 1},
  {parent_code_id: 302035,    parent_code_name: 'DIGITAL',       code_id: 30203503,      code_name: 'd',               explanation: '텍스트'                       ,etc: '컴포넌트-유형-디지털파일-텍스트',enabled: 1},
  {parent_code_id: 302035,    parent_code_name: 'DIGITAL',       code_id: 30203504,      code_name: 'e',               explanation: '3D파일'                       ,etc: '컴포넌트-유형-디지털파일-3D파일',enabled: 1},
  {parent_code_id: 3020,      parent_code_name: 'TYPE',          code_id: 302040,        code_name: 'Ⅷ',               explanation: '판화류'                       ,etc: '[판화 | 판화원판]',enabled: 1},
  {parent_code_id: '-',         parent_code_name: '-',             code_id: 40,            code_name: 'DEVICE',          explanation: '송출장비'                       ,etc: '송출장비 [ 키오스크 ]',enabled: 1},
  {parent_code_id: 40,        parent_code_name: 'DEVICE',        code_id: 4000,          code_name: 'KIOSK',           explanation: '키오스크'                       ,etc: '키오스크 [ 키오스크-유성 | 키오스크-동구 | 키오스크-서구 | 키오스크-대덕구 ]',enabled: 1},
  {parent_code_id: 4000,      parent_code_name: 'KIOSK',         code_id: 400000,        code_name: 'YUSEONG',         explanation: '유성'                       ,etc: '키오스크 유성',enabled: 1},
  {parent_code_id: 4000,      parent_code_name: 'KIOSK',         code_id: 400001,        code_name: 'DONGGU',          explanation: '동구'                       ,etc: '키오스크 동구',enabled: 1},
  {parent_code_id: 4000,      parent_code_name: 'KIOSK',         code_id: 400002,        code_name: 'SEOGU',           explanation: '서구'                       ,etc: '키오스크 서구',enabled: 1},
  {parent_code_id: 4000,      parent_code_name: 'KIOSK',         code_id: 400003,        code_name: 'DAEDEOKGU',       explanation: '대덕구'                       ,etc: '키오스크 대덕구',enabled: 1},
]

</script>

<style lang="sass">
.q-input, .q-toggle, .q-select
  margin-bottom: 10px

.q-btn
  float: right

.my-sticky-header-table
  /* height or max-height is important */
  //height: 1000px

  .q-table__top,
  .q-table__bottom,
  thead tr:first-child th
    /* bg color is important for th; just specify one */
    background-color: #c1f4cd

  thead tr th
    position: sticky
    z-index: 1
  thead tr:first-child th
    top: 0

  /* this is when the loading indicator appears */
  &.q-table--loading thead tr:last-child th
    /* height of all previous header rows */
    top: 48px

  .q-table tr td
    text-overflow: ellipsis
    white-space: nowrap
    max-width: 300px
    overflow: hidden
</style>


