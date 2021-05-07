type GradeType = 'g_one' | 'g_two' | 'g_three'
export const useTranslateGrade = () => {
  const translateGrade = (grade: GradeType) => {
    if (grade === 'g_one') return 'GⅠ'
    if (grade === 'g_two') return 'GⅡ'
    if (grade === 'g_three') return 'GⅢ'
  }

  return {
    translateGrade
  }
}


type FieldType = 'turf' | 'dirt'
export const useTranslateField = () => {
  const translateField = (field: FieldType) => {
    if (field === 'turf') return '芝'
    return 'ダート'
  }

  return {
    translateField
  }
}