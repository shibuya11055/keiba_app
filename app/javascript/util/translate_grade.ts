// export const translateGrade = (grade: string): string => {
//   if (grade === 'g_one') return 'GⅠ'
//   if (grade === 'g_two') return 'GⅡ'
//   if (grade === 'g_three') return 'GⅢ'
// }

export const useTranslateGrade = () => {
  const translateGrade = (grade: string): string => {
    if (grade === 'g_one') return 'GⅠ'
    if (grade === 'g_two') return 'GⅡ'
    if (grade === 'g_three') return 'GⅢ'
  }

  return {
    translateGrade
  }
}