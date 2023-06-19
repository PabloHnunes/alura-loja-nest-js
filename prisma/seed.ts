import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();
async function main() {
  const pablo = await prisma.users.upsert({
    where: {
      email: 'pablo.nunes@tecadi.com.br',
    },
    update: {},
    create: {
      email: 'teste@tecadi.com.br',
      name: 'Pablo HH Nunes',
      cpf: '',
      password: '123456',
      profile: {
        create: {
          description: 'Gerente de Projetos',
          profilescol: 'Teste',
          profile_type: {
            create: {
              description: 'Admin',
            },
          },
        },
      },
    },
  });
  console.log({ pablo });
}
main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error(e);
    await prisma.$disconnect();
    process.exit(1);
  });
