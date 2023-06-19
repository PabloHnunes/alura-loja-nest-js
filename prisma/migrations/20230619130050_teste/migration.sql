-- CreateEnum
CREATE TYPE "answers_type" AS ENUM ('RADIO', 'MULTIPLE', 'PHOTO', 'TEXTAREA');

-- CreateTable
CREATE TABLE "Users" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "external_code" TEXT,
    "token" TEXT,
    "profilesId" INTEGER,

    CONSTRAINT "Users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profiles" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "profilescol" TEXT NOT NULL,
    "profile_type_id" INTEGER NOT NULL,

    CONSTRAINT "Profiles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ProfilesTypes" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "ProfilesTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Checklist" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL,
    "schedule_id" INTEGER NOT NULL,
    "checklist_type_id" INTEGER NOT NULL,
    "code" TEXT NOT NULL,

    CONSTRAINT "Checklist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChecklistQuestions" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "active" BOOLEAN NOT NULL,
    "checklist_id" INTEGER NOT NULL,
    "answer_request" BOOLEAN NOT NULL,
    "answer_correct_id" INTEGER NOT NULL,

    CONSTRAINT "ChecklistQuestions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChecklistAnswers" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "checklist_question_id" INTEGER NOT NULL,
    "correct" BOOLEAN NOT NULL,
    "checklist_answer_type" "answers_type" NOT NULL,

    CONSTRAINT "ChecklistAnswers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChecklistAnswersValues" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "checklist_answer_id" INTEGER NOT NULL,

    CONSTRAINT "ChecklistAnswersValues_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExecChecklist" (
    "id" SERIAL NOT NULL,
    "checklist_question_id" INTEGER NOT NULL,
    "checklist_answer_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "data_executate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "comments" TEXT NOT NULL,
    "queue_exec_checklist_id" INTEGER NOT NULL,

    CONSTRAINT "ExecChecklist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QueueExecChecklist" (
    "id" SERIAL NOT NULL,
    "checklist_id" INTEGER NOT NULL,
    "date_start" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "date_end" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "QueueExecChecklist_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "QueueChecklistTags" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "queue_exec_checklist_id" INTEGER NOT NULL,

    CONSTRAINT "QueueChecklistTags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ExecChecklistValues" (
    "id" SERIAL NOT NULL,
    "checklist_answer_value_id" INTEGER NOT NULL,
    "exec_checklist_id" INTEGER NOT NULL,

    CONSTRAINT "ExecChecklistValues_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ChecklistTypes" (
    "id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "ChecklistTypes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Attachments" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "size" INTEGER NOT NULL,
    "exec_checklist_id" INTEGER NOT NULL,

    CONSTRAINT "Attachments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Users_email_key" ON "Users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Profiles_profile_type_id_key" ON "Profiles"("profile_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "ChecklistTypes_description_key" ON "ChecklistTypes"("description");

-- AddForeignKey
ALTER TABLE "Users" ADD CONSTRAINT "Users_profilesId_fkey" FOREIGN KEY ("profilesId") REFERENCES "Profiles"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profiles" ADD CONSTRAINT "Profiles_profile_type_id_fkey" FOREIGN KEY ("profile_type_id") REFERENCES "ProfilesTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Checklist" ADD CONSTRAINT "Checklist_checklist_type_id_fkey" FOREIGN KEY ("checklist_type_id") REFERENCES "ChecklistTypes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChecklistQuestions" ADD CONSTRAINT "ChecklistQuestions_checklist_id_fkey" FOREIGN KEY ("checklist_id") REFERENCES "Checklist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChecklistAnswers" ADD CONSTRAINT "ChecklistAnswers_checklist_question_id_fkey" FOREIGN KEY ("checklist_question_id") REFERENCES "ChecklistQuestions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ChecklistAnswersValues" ADD CONSTRAINT "ChecklistAnswersValues_checklist_answer_id_fkey" FOREIGN KEY ("checklist_answer_id") REFERENCES "ChecklistAnswers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExecChecklist" ADD CONSTRAINT "ExecChecklist_checklist_question_id_fkey" FOREIGN KEY ("checklist_question_id") REFERENCES "ChecklistQuestions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExecChecklist" ADD CONSTRAINT "ExecChecklist_checklist_answer_id_fkey" FOREIGN KEY ("checklist_answer_id") REFERENCES "ChecklistAnswers"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExecChecklist" ADD CONSTRAINT "ExecChecklist_queue_exec_checklist_id_fkey" FOREIGN KEY ("queue_exec_checklist_id") REFERENCES "QueueExecChecklist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QueueExecChecklist" ADD CONSTRAINT "QueueExecChecklist_checklist_id_fkey" FOREIGN KEY ("checklist_id") REFERENCES "Checklist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "QueueChecklistTags" ADD CONSTRAINT "QueueChecklistTags_queue_exec_checklist_id_fkey" FOREIGN KEY ("queue_exec_checklist_id") REFERENCES "QueueExecChecklist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ExecChecklistValues" ADD CONSTRAINT "ExecChecklistValues_checklist_answer_value_id_fkey" FOREIGN KEY ("checklist_answer_value_id") REFERENCES "ChecklistAnswersValues"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Attachments" ADD CONSTRAINT "Attachments_exec_checklist_id_fkey" FOREIGN KEY ("exec_checklist_id") REFERENCES "ExecChecklist"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
