export default (app) => {
  app.post(
    `/tenant/:tenantId/lesson`,
    require('./lessonCreate').default,
  );
  app.put(
    `/tenant/:tenantId/lesson/:id`,
    require('./lessonUpdate').default,
  );
  app.post(
    `/tenant/:tenantId/lesson/import`,
    require('./lessonImport').default,
  );
  app.delete(
    `/tenant/:tenantId/lesson`,
    require('./lessonDestroy').default,
  );
  app.get(
    `/tenant/:tenantId/lesson/autocomplete`,
    require('./lessonAutocomplete').default,
  );
  app.get(
    `/tenant/:tenantId/lesson`,
    require('./lessonList').default,
  );
  app.get(
    `/tenant/:tenantId/lesson/:id`,
    require('./lessonFind').default,
  );
};