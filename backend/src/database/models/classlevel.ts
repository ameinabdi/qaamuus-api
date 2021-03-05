import { DataTypes } from 'sequelize';

/**
 * Classlevel database model.
 * See https://sequelize.org/v5/manual/models-definition.html to learn how to customize it.
 */
export default function (sequelize) {
  const classlevel = sequelize.define(
    'classlevel',
    {
      id: {
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        primaryKey: true,
      },
      className: {
        type: DataTypes.TEXT,
        allowNull: false,
        validate: {
          notEmpty: true,
        }
      },
      classDescription: {
        type: DataTypes.TEXT,
      },
      active: {
        type: DataTypes.BOOLEAN,
        allowNull: false,
        defaultValue: false,
      },
      importHash: {
        type: DataTypes.STRING(255),
        allowNull: true,        
      },
    },
    {
      indexes: [
        {
          unique: true,
          fields: ['importHash', 'tenantId'],
          where: {
            deletedAt: null,
          },
        },

      ],
      timestamps: true,
      paranoid: true,
    },
  );

  classlevel.associate = (models) => {
    models.classlevel.belongsTo(models.level, {
      as: 'level',
      constraints: false,
    });


    
    models.classlevel.belongsTo(models.tenant, {
      as: 'tenant',
    });

    models.classlevel.belongsTo(models.user, {
      as: 'createdBy',
    });

    models.classlevel.belongsTo(models.user, {
      as: 'updatedBy',
    });
  };

  return classlevel;
}
